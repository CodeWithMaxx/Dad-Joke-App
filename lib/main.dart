import 'package:dad_joke/app/auth/bloc/auth_bloc.dart';
import 'package:dad_joke/app/home/bloc/joke_bloc.dart';
import 'package:dad_joke/app/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<JokeBloc>(
        create: (context) => JokeBloc(),
      ),
      BlocProvider<AuthBloc>(create: (context) => AuthBloc())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
