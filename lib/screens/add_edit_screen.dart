import 'package:contact/Utils/network.dart';
import 'package:contact/Widgets/my_button_widget.dart';
import 'package:contact/Widgets/my_textfield_widget.dart';
import 'package:flutter/material.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({super.key});

  static TextEditingController nameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static int id = 0;
  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.redAccent,
          title: Text(AddEditScreen.id == 0 ? 'مخاطب جدید' : 'ویرایش مخاظب',
              style: const TextStyle(fontSize: 16)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            MyTextField(
              controller: AddEditScreen.nameController,
              hintText: 'نام',
              inputType: TextInputType.name,
              errorMessage: 'نام را وارد کنید',
            ),
            MyTextField(
              controller: AddEditScreen.phoneController,
              hintText: 'تلفن',
              inputType: TextInputType.number,
              errorMessage: 'تلفن را وارد کنید',
            ),
            const SizedBox(height: 20),
            ButtonWidget(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Network.showInternetError(context);
                    Future.delayed(const Duration(seconds: 3)).then((value) {
                      if (Network.IsConnected) {
                        if (AddEditScreen.id == 0) {
                          Network.postData(
                              phone: AddEditScreen.phoneController.text,
                              fullName: AddEditScreen.nameController.text);
                        } else {
                          Network.putData(
                              id: AddEditScreen.id.toString(),
                              phone: AddEditScreen.phoneController.text,
                              fullName: AddEditScreen.nameController.text);
                        }
                        Navigator.pop(context);
                      } else {
                        Network.showInternetError(context);
                      }
                    });
                  }
                },
                text: AddEditScreen.id == 0 ? 'اضافه کردن' : 'ویرایش کردن')
          ]),
        ),
      ),
    );
  }
}
