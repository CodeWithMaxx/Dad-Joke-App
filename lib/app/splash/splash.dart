import 'package:dad_joke/app/auth/screen/auth_screen.dart';
import 'package:dad_joke/app/home/screen/home.dart';
import 'package:dad_joke/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<void> stayLogin(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userInfo = pref.getString(
      'login',
    );
    if(userInfo==null){
       Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AuthScreen()));
    }
    else{
      userInfo != ''
        ? Future.delayed(const Duration(seconds: 3)).then((navigate) =>
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => JokeHomePage())))
        : Future.delayed(const Duration(seconds: 3)).then((navigate) =>
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AuthScreen())));
    }
  }

  @override
  void initState() {
    stayLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                child: Assets.images.jokelogo.image(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
