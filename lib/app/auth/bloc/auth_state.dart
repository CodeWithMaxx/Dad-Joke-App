part of 'auth_bloc.dart';

sealed class AuthState {}

sealed class AuthActionState extends AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthLoadedSuccessState extends AuthState {
  final AuthModel authModel;

  AuthLoadedSuccessState({required this.authModel});
}

final class AuthFailedErrorState extends AuthState {}

final class NavigateToHomePageActionState extends AuthActionState {}
