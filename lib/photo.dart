import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:lionchat/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class photo extends StatefulWidget {
  final File photo1;

  const photo({Key? key, required this.photo1}) : super(key: key);

  @override
  State<photo> createState() => _photoState();
}

class _photoState extends State<photo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: double.infinity,
          child: Image.file(widget.photo1, fit: BoxFit.cover),
        ),
        Container(
            width: double.infinity,
            color: Colors.black.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await GallerySaver.saveImage(widget.photo1.path,
                          albumName: "flutter");

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
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
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.download,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            )),
      ]),
    );
  }
}
