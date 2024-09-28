import 'dart:developer';

import 'package:dad_joke/app/auth/bloc/auth_bloc.dart';
import 'package:dad_joke/app/home/screen/home.dart';
import 'package:dad_joke/extension/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthBloc authBloc;
  @override
  void initState() {
    authBloc = AuthBloc();
    login();
    super.initState();
  }

  void login() {
    authBloc.add(LoginToJokeAppEvent(
        email: emailController.text, password: passwordController.text,));
  }

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.deepPurpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'LOGIN',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 7),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.6),
                  borderRadius: BorderRadius.circular(5)),
              width: double.infinity,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 7),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.6),
                  borderRadius: BorderRadius.circular(5)),
              width: double.infinity,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 7),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.6),
                  borderRadius: BorderRadius.circular(5)),
              width: double.infinity,
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              bloc: authBloc,
              listenWhen: (previous, current) => current is AuthActionState,
              buildWhen: (previous, current) => current is! AuthActionState,
              listener: (context, state) {
                if (state is NavigateToHomePageActionState || nameController.text.isValidName(context)) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => JokeHomePage(userName:nameController.text ,)));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Login Successful'),
                    behavior: SnackBarBehavior.floating,
                  ));
                  log("navigation success");
                }
              },
              builder: (context, state) {
                switch (state.runtimeType) {
                  case AuthLoadingState:
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );

                  case AuthLoadedSuccessState:
                    return SizedBox(
                      height: 45,
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () {
                            if(nameController.text.isValidName(context)){
                              login();
                            authBloc.add(NavigateToHomePageEvent());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: const Color(0xff2f3e46)),
                          child: const Text(
                            'LogIn',
                            style: TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    );
                  case AuthFailedErrorState:
                    return const Center(
                      child: Text('404 Error'),
                    );

                  default:
                    return const Center(
                      child: Text('State not found'),
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
