import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class singin extends StatefulWidget {
  singin({Key? key}) : super(key: key);

  @override
  State<singin> createState() => _singinState();
}

class _singinState extends State<singin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      hintText: "Email",
                      hintStyle: Theme.of(context).textTheme.subtitle1,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                            width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                            width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      hintText: "Password",
                      hintStyle: Theme.of(context).textTheme.subtitle1,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                            width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                            width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("chat");
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: const EdgeInsets.only(
                      left: 100, right: 100, top: 15, bottom: 15),
                  shape: const StadiumBorder(),
                ),
                child: const Text("sing in"),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                      left: 100, right: 100, top: 15, bottom: 15),
                  shape: const StadiumBorder(),
                ),
                child: const Text("sing up"),
              ),
              const Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
