import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class people extends StatefulWidget {
  people({Key? key}) : super(key: key);

  @override
  State<people> createState() => _peopleState();
}

class _peopleState extends State<people> {
  @override
  void initState() {
    getcontacts();
    super.initState();
  }

  List<Contact>? contacts;
  getcontacts() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      ),
      body: (contacts == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: contacts?.length,
              itemBuilder: (BuildContext context, int index) {
                Uint8List? image = contacts![index].photo;
                return ListTile(
                  onTap: () {
                    launchUrl(
                      Uri(
                          scheme: 'tel',
                          path: contacts![index].phones.first.number),
                    );
                  },
                  leading: (image == null)
                      ? const CircleAvatar(
                          child: Icon(Icons.person),
                        )
                      : CircleAvatar(
                          backgroundImage: MemoryImage(image),
                        ),
                  title: Text(
                    contacts![index].displayName,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: (contacts![index].phones.isEmpty)
                      ? const Text("------")
                      : Text(
                          contacts![index].phones.first.number,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                );
              },
            ),
    );
  }
}
