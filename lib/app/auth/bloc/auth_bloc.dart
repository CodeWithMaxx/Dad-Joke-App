import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dad_joke/app/auth/model/auth_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<LoginToJokeAppEvent>(loginToJokeAppEvent);
    on<NavigateToHomePageEvent>(navigateToHomePageEvent);
  }

  FutureOr<void> loginToJokeAppEvent(
      LoginToJokeAppEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      final httpClient = http.Client();
      final AuthModel authModel;
      final url = Uri.parse('https://recruitment-api.pyt1.stg.jmr.pl/login');
      var response = await httpClient.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"login": event.email, "password": event.password}));
      if (response.statusCode == 200) {
        var decodedAuthResponse = jsonDecode(response.body);
        await pref.setString('login', event.email);
        authModel = AuthModel.fromJson(decodedAuthResponse);
        emit(AuthLoadedSuccessState(authModel: authModel));

        log(decodedAuthResponse.toString());
      }
    } catch (error) {
      emit(AuthFailedErrorState());
      log(error.toString());
    }
  }

  FutureOr<void> navigateToHomePageEvent(
      NavigateToHomePageEvent event, Emitter<AuthState> emit) {
    emit(NavigateToHomePageActionState());
  }
}
