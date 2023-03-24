import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class wellcomescrean extends StatefulWidget {
  const wellcomescrean({Key? key}) : super(key: key);

  @override
  State<wellcomescrean> createState() => _wellcomescreanState();
}

class _wellcomescreanState extends State<wellcomescrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            SvgPicture.asset(
              height: 250,
              "images/Prismatic-Lion-10-No-Background.svg",
              color: const Color.fromARGB(255, 93, 173, 234),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Lion chat",
              style: Theme.of(context).textTheme.headline1,
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              "welcome to our chat app",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "free messaging and texting any where ",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const Spacer(
              flex: 1,
            ),
            TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("singin");
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  "next",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
