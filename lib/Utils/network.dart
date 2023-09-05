import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/contact.dart';

class Network {
  static Uri url = Uri.parse('https://retoolapi.dev/MUOjEr/Contact');
  static Uri uriWithId(String id) {
    Uri url = Uri.parse('https://retoolapi.dev/MUOjEr/Contact/$id');
    return url;
  }

  static List<Contact> contacts = [];

  static bool IsConnected = false;

  //! Show Internet Error
  static void showInternetError(BuildContext context) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        width: 100,
        title: 'خطا',
        confirmBtnText: 'باشه',
        confirmBtnTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
        confirmBtnColor: Colors.redAccent,
        text: 'شما به اینترتت متصل نیستید');
  }

  //! Check Inetrnet
  static Future<bool> chechkInternet(BuildContext context) async {
    Connectivity().onConnectivityChanged.listen((status) {
      if (status == ConnectivityResult.wifi ||
          status == ConnectivityResult.mobile) {
        IsConnected = true;
      } else {
        IsConnected = false;
        showInternetError(context);
      }
      print(IsConnected);
    });
    return IsConnected;
  }

  //! Get Data
  static getData() async {
    contacts.clear();
    http.get(Network.url).then((response) {
      if (response.statusCode == 200) {
        List jsonDecode = convert.jsonDecode(response.body);
        for (var json in jsonDecode) {
          contacts.add(Contact.fromJson(json));
        }
      }
    });
  }

  //* Post Data

  static void postData(
      {required String phone, required String fullName}) async {
    Contact contact = Contact(phone: phone, fullname: fullName);
    http.post(url, body: contact.toJson()).then((response) => {
          // ignore: avoid_print
          print(response.body)
        });
  }

  //! Put Data
  static void putData(
      {required String id,
      required String phone,
      required String fullName}) async {
    Contact contact = Contact(phone: phone, fullname: fullName);
    http
        .put(uriWithId(id), body: contact.toJson())
        .then((response) => {print(response.body)});
  }

  //* Delete Contact

  static void deletecontact(String id) {
    http.delete(Network.uriWithId(id)).then((value) {
      getData();
    });
  }
}
