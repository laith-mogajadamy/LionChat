import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:lionchat/camera.dart';
import 'package:lionchat/masseging.dart';
import 'package:lionchat/people.dart';
import 'package:shared_preferences/shared_preferences.dart';

class chats extends StatefulWidget {
  chats({Key? key}) : super(key: key);

  @override
  State<chats> createState() => _chatsState();
}

class _chatsState extends State<chats> {
  @override
  void initState() {
    super.initState();
  }

  int currentindex = 0;
  bool issearching = false;
  TextEditingController controller = TextEditingController();
  List<Map> people1 = [
    {
      "id": "0",
      "name": "Abodeh",
      "photo": "images/IMG_20210514_084925.jpg",
      "lastmassege": "hello",
      "time": "1 hour ago"
    },
    {
      "id": "1",
      "name": "Mahmod",
      "photo": "images/IMG_20210611_115122.jpg",
      "lastmassege": "hey",
      "time": "1 day ago"
    },
    {
      "id": "2",
      "name": "Laith",
      "photo": "images/IMG_20210829_192750.jpg",
      "lastmassege": "hey",
      "time": "1 day ago"
    },
    {
      "id": "3",
      "name": "kareem",
      "photo": "images/IMG_20210624_172934.jpg",
      "lastmassege": "hey",
      "time": "1 hour ago"
    },
    {
      "id": "4",
      "name": "Eyad",
      "photo": "images/IMG_20210829_192727.jpg",
      "lastmassege": "hey",
      "time": "3 hour ago"
    },
    {
      "id": "5",
      "name": "Nour",
      "photo": "images/IMG_20210827_175055.jpg",
      "lastmassege": "sticker",
      "time": "1 hour ago"
    },
    {
      "id": "6",
      "name": "Fares",
      "photo": "images/IMG_20210829_192901.jpg",
      "lastmassege": "sticker",
      "time": "1 hour ago"
    },
  ];
  List<Contact> fcontacts = [];
  List<Contact> contacts = [];
  filtercontacts() {
    List<Contact> _contacts = [];
    // _contacts.addAll(people1);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                issearching = !issearching;
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: Row(
          children: [
            (issearching)
                ? Container()
                : Text(
                    "Lion Chat",
                    style: Theme.of(context).textTheme.headline2,
                  ),
            (issearching)
                ? SizedBox(
                    width: 250,
                    child: Form(
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: "search",
                          hintStyle: Theme.of(context).textTheme.headline3,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.white),
                          ),
                          border: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.white),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
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
                                child: Text("cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  SystemNavigator.pop();
                                },
                                child: Text("ok"),
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
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount:
            (controller.text.isEmpty) ? people1.length : fcontacts.length,
        itemBuilder: (BuildContext context, int i) {
          Contact cont =
              (controller.text.isNotEmpty) ? fcontacts[i] : contacts[i];
          Uint8List? image = (controller.text.isNotEmpty)
              ? fcontacts[i].photo
              : contacts[i].photo;
          return InkWell(
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => masseging(
                    photo: people1[i]["photo"],
                    name: people1[i]["name"],
                    lastmassege: people1[i]["lastmassege"],
                    time: people1[i]["time"],
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    "${people1[i]["photo"]}",
                  ),
                ),
                title: Text(
                  "${people1[i]["name"]}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  "${people1[i]["lastmassege"]}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: Text(
                  "${people1[i]["time"]}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
