import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lionchat/camera.dart';
import 'package:lionchat/chats.dart';
import 'package:lionchat/masseging.dart';
import 'package:lionchat/people.dart';
import 'package:lionchat/singin.dart';
import 'package:lionchat/wellcomescrean.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class search2 extends StatefulWidget {
  search2({Key? key}) : super(key: key);

  @override
  State<search2> createState() => _search2State();
}

class _search2State extends State<search2> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    getcontacts();
    controller.addListener(() {
      filtercontacts();
    });
    super.initState();
  }

  List<Contact> contacts = [];
  List<Contact> fcontacts = [];
  filtercontacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (controller.text.isNotEmpty) {
      _contacts.retainWhere((Contact) {
        String c = controller.text.toLowerCase();
        String n = Contact.displayName.toLowerCase();
        return n.contains(c);
      });
      setState(() {
        fcontacts = _contacts;
      });
    } else {
      fcontacts.clear();
      setState(() {});
    }
  }

  getcontacts() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      setState(() {});
    }
  }

  setprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lion Chat",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        width: 270,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      AssetImage("images/IMG_20210829_192750.jpg")),
              currentAccountPictureSize: Size.square(85),
              accountName: Text("user name"),
              margin: EdgeInsets.all(0),
              accountEmail: Text("user email"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.person,
                size: 30,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text("my account",
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.settings,
                size: 30,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text("settings",
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.info,
                size: 30,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title:
                  Text("about", style: Theme.of(context).textTheme.bodyText1),
            ),
            const Divider(height: 8, thickness: 1),
            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Exit",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        content: Text("are you sure"),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  SystemNavigator.pop();
                                },
                                child: const Text("ok"),
                              ),
                            ],
                          ),
                        ],
                      );
                    });
              },
              leading: Icon(
                Icons.exit_to_app,
                size: 30,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text("exit", style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 370,
                    child: Form(
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: "search",
                          hintStyle: Theme.of(context).textTheme.subtitle1,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: (controller.text.isNotEmpty)
                    ? fcontacts.length
                    : contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  Contact cont = (controller.text.isNotEmpty)
                      ? fcontacts[index]
                      : contacts[index];
                  Uint8List? image = (controller.text.isNotEmpty)
                      ? fcontacts[index].photo
                      : contacts[index].photo;
                  return ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SizedBox(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      onTap: () {},
                                      leading: Icon(
                                        Icons.chat,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                      title: Text(
                                        "massege",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        launchUrl(
                                          Uri(
                                              scheme: 'tel',
                                              path: cont.phones.first.number),
                                        );
                                      },
                                      leading: Icon(
                                        Icons.call,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                      title: Text(
                                        "call",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    leading: (image == null)
                        ? const CircleAvatar(
                            child: Icon(Icons.person),
                          )
                        : CircleAvatar(
                            backgroundImage: MemoryImage(image),
                          ),
                    title: (cont.displayName.isEmpty)
                        ? const Text("===")
                        : Text(
                            cont.displayName,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                    subtitle: (cont.phones.isEmpty)
                        ? const Text("------")
                        : Text(
                            cont.phones.first.number,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
