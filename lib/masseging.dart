import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class masseging extends StatefulWidget {
  String? name;
  String? photo;
  String? time;
  String? lastmassege;

  masseging(
      {Key? key,
      required this.photo,
      required this.name,
      required this.lastmassege,
      required this.time})
      : super(key: key);

  @override
  State<masseging> createState() => _massegingState();
}

class _massegingState extends State<masseging> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController ms = TextEditingController();
  List masseges = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 110,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("${widget.photo}"),
            ),
          ],
        ),
        title: ListTile(
          title: Text(
            "${widget.name}",
            style: Theme.of(context).textTheme.headline3,
          ),
          subtitle: Text(
            "${widget.time}",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: SvgPicture.asset(
                    height: 250,
                    "images/Prismatic-Lion-10-No-Background.svg",
                    color: const Color.fromARGB(255, 93, 173, 234),
                  ),
                ),
                ListView.builder(
                  itemCount: masseges.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.only(
                          top: 15, left: 15, bottom: 15, right: 0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 17,
                            backgroundImage: AssetImage("${widget.photo}"),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor!,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  "${masseges[index]}",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              )),
                          Icon(
                            Icons.check,
                            color:
                                Theme.of(context).appBarTheme.backgroundColor!,
                            size: 15,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 15,
                  color: Theme.of(context).appBarTheme.backgroundColor!,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10, left: 10),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.mic,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  width: 250,
                  child: Form(
                    child: TextFormField(
                      controller: ms,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 241, 245, 248),
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.emoji_emotions_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.attachment,
                            color: Colors.grey,
                          ),
                        ),
                        hintText: "massege",
                        hintStyle: Theme.of(context).textTheme.subtitle1,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary,
                              width: 2),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary,
                              width: 2),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      masseges.add(ms.text);
                    });
                    ms.clear();
                  },
                  icon: Icon(
                    Icons.subdirectory_arrow_right,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
