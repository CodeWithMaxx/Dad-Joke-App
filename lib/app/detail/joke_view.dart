import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JokeDetailView extends StatelessWidget {
  String? joke;
  JokeDetailView({super.key, this.joke});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff2f3e46),
            title: Text(
              'Joke View',
              style: GoogleFonts.poppins(
                  color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            width: MediaQuery.of(context).size.width,
            child: Text(joke.toString()),
          )),
    );
  }
}
