import 'package:contact/Utils/network.dart';
import 'package:contact/screens/add_edit_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (Network.IsConnected) {
        Network.getData().then((value) async {
          await Future.delayed(const Duration(seconds: 3));
          setState(() {});
        });
      } else {
        Network.showInternetError(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.redAccent,
          onPressed: () {
            AddEditScreen.id = 0;
            AddEditScreen.nameController.text = '';
            AddEditScreen.phoneController.text = '';

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddEditScreen())).then((value) {
              Network.getData().then((value) async {
                await Future.delayed(const Duration(seconds: 5));
                setState(() {});
              });
            });
          },
          child: const Icon(Icons.add)),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: const Text('دفترچه تلفن آنلاین', style: TextStyle(fontSize: 16)),
        centerTitle: true,
        leading: const Icon(Icons.import_contacts_sharp),
        actions: [
          IconButton(
              onPressed: () {
                if (Network.IsConnected) {
                  Network.getData().then((value) async {
                    await Future.delayed(const Duration(seconds: 3));
                    setState(() {});
                  });
                } else {
                  Network.showInternetError(context);
                }
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: ListView.builder(
          itemCount: Network.contacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: () async {
                Network.deletecontact(Network.contacts[index].id.toString());
                await Future.delayed(const Duration(seconds: 5));
                setState(() {});
              },
              leading: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Text(
                  (index + 1).toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              trailing: IconButton(
                  onPressed: () {
                    AddEditScreen.id = Network.contacts[index].id;
                    AddEditScreen.nameController.text =
                        Network.contacts[index].fullname;
                    AddEditScreen.phoneController.text =
                        Network.contacts[index].phone;
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddEditScreen()))
                        .then((value) {
                      Network.getData().then((value) async {
                        await Future.delayed(const Duration(seconds: 5));
                        setState(() {});
                      });
                    });
                  },
                  icon: const Icon(Icons.edit)),
              title: Text(Network.contacts[index].fullname),
              subtitle: Text(Network.contacts[index].phone),
            );
          }),
    );
  }
}
