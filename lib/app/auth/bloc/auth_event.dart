part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginToJokeAppEvent extends AuthEvent {
  final String email;
  final String password;

  LoginToJokeAppEvent({required this.email, required this.password});
}


final class NavigateToHomePageEvent extends AuthEvent{}
