import 'package:dad_joke/app/home/screen/home.dart';
import 'package:dad_joke/app/splash/splash.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';



abstract class HomeBuilder extends State<JokeHomePage>{

  Widget appDrawer(String? userName, BuildContext context) => Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xff2f3e46),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  userName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.4,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Close the drawer and navigate to Home if needed
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Logout'),
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
               pref.remove('login').then((navigate) =>
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Splash())));
            },
          ),
        ],
      ),
    );
}

