import 'dart:convert';
import 'dart:io';

import 'package:contact/Widgets/my_button_widget.dart';
import 'package:contact/Widgets/my_textfield_widget.dart';
import 'package:contact/screens/home_screen.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LicencseScreen extends StatelessWidget {
  LicencseScreen({super.key});

  Future<String?> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
  }

  void showSuccesDialog(BuildContext context) {
    CoolAlert.show(
        width: 100,
        title: 'موفق',
        text: 'کد با موفقیت کپی شد ',
        confirmBtnText: 'باشه',
        confirmBtnTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
        context: context,
        type: CoolAlertType.success);
  }

  final TextEditingController systemCodeController = TextEditingController();

  final TextEditingController activeCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getDeviceId().then((value) async {
      systemCodeController.text = value ?? '';
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: const Text('فعال سازی', style: TextStyle(fontSize: 16)),
        centerTitle: true,
        leading: const Icon(Icons.import_contacts_sharp),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Clipboard.setData(
                    ClipboardData(text: "$systemCodeController.text"));
                showSuccesDialog(context);
              },
              child: MyTextField(
                  controller: systemCodeController,
                  hintText: 'کد سیستم',
                  inputType: TextInputType.text,
                  errorMessage: 'کد سیستم را وارد کنید',
                  isEnabled: false),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MyTextField(
                controller: activeCodeController,
                hintText: 'کد فعال سازی ',
                inputType: TextInputType.text,
                errorMessage: 'کد فعال سازی را وارد کنید '),
          ),
          const SizedBox(height: 20),
          ButtonWidget(
              onPressed: () async {
                var bytes = utf8.encode(systemCodeController.text);
                var digset = sha512256.convert(bytes);
                print(digset);
                if (activeCodeController.text == digset.toString()) {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setBool('isActive', true);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                }
              },
              text: 'فعال سازی ')
        ],
      ),
    );
  }
}
