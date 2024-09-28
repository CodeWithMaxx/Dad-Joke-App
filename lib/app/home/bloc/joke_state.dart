part of 'joke_bloc.dart';

sealed class JokeHomeState {}

sealed class JokeHomeActionState extends JokeHomeState {}

final class JokeInitialState extends JokeHomeState {}

final class JokeLoadingState extends JokeHomeState {}

class JokeLoadedSuccessState extends JokeHomeState {
  List<Results> jokeDataList = [];
  JokeLoadedSuccessState({
    required this.jokeDataList,
  });
  
}

final class JokeFailedErrorState extends JokeHomeState {}

final class NavigateToJokeDetailsViewActionState extends JokeHomeActionState {}

final class SearchingJokeDataFromApiActionState extends JokeHomeActionState {}
