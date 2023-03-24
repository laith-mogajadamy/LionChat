import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:lionchat/photo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class camera extends StatefulWidget {
  camera({Key? key}) : super(key: key);

  @override
  State<camera> createState() => _cameraState();
}

class _cameraState extends State<camera> {
  List<photostybe> photos = [];
  List<photostybe> slectedphotos = [];
  late File photo1;
  late File ifiles;

  @override
  void initState() {
    request();

    super.initState();
  }

  request() async {
    if (await Permission.camera.isGranted &&
        await Permission.microphone.isGranted &&
        await Permission.manageExternalStorage.isGranted &&
        await Permission.storage.isGranted) {
    } else {
      await Permission.camera.request();
      await Permission.microphone.request();
      await Permission.manageExternalStorage.request();
      await Permission.storage.request();
    }
  }

  void openCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CameraCamera(
          enableAudio: true,
          onFile: (file) {
            photos.add(photostybe(
              file,
              false,
            ));
            Navigator.pop(context);
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        actions: [
          (slectedphotos.isNotEmpty)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                    IconButton(
                      onPressed: () async {
                        for (var i = 0; i < slectedphotos.length; i++) {
                          await GallerySaver.saveImage(
                              slectedphotos[i].photo.path,
                              albumName: "flutter");
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: SizedBox(
                            height: 40,
                            child: Card(
                                color: Colors.grey,
                                child: Center(
                                    child: Text(
                                  "photos is saved",
                                  style: Theme.of(context).textTheme.headline4,
                                ))),
                          ),
                          duration: const Duration(seconds: 4),
                        ));
                        setState(() {
                          for (var i = 0; i < photos.length; i++) {
                            photos[i].isselcted = false;
                          }
                          slectedphotos.clear();
                        });
                      },
                      icon: const Icon(Icons.download),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          for (var i = 0; i < slectedphotos.length; i++) {
                            photos.removeWhere((element) =>
                                element.photo == slectedphotos[i].photo);
                          }
                          slectedphotos.clear();
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                )
              : Container(
                  width: 0,
                )
        ],
        title: Text(
          "Lion Camera",
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
      body: (photos.isEmpty)
          ? Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            )
          : GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: photos.length,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (slectedphotos.isNotEmpty)
                      ? () {
                          setState(() {
                            photos[index].isselcted = !photos[index].isselcted;
                            if (photos[index].isselcted == true) {
                              slectedphotos
                                  .add(photostybe(photos[index].photo, true));
                            } else if (photos[index].isselcted == false) {
                              slectedphotos.removeWhere((element) =>
                                  element.photo == photos[index].photo);
                            }
                          });
                        }
                      : () {
                          photo1 = photos[index].photo;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => photo(
                                photo1: photo1,
                              ),
                            ),
                          );
                          print(photos[index].photo.path);
                        },
                  onLongPress: () {
                    setState(() {
                      photos[index].isselcted = !photos[index].isselcted;
                      if (photos[index].isselcted == true) {
                        slectedphotos
                            .add(photostybe(photos[index].photo, true));
                      } else if (photos[index].isselcted == false) {
                        slectedphotos.removeWhere(
                            (element) => element.photo == photos[index].photo);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: (photos[index].isselcted)
                            ? Border.all(
                                color: Colors.blue,
                                width: 5,
                              )
                            : Border.all(width: 0)),
                    child: Image.file(
                      photos[index].photo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openCamera,
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
      ),
    );
  }
}

class photostybe {
  late File photo;
  bool isselcted = false;
  photostybe(this.photo, this.isselcted);
}
