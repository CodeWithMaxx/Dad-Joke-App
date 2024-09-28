part of 'joke_bloc.dart';

sealed class JokeEvent {}

class FetchJokesFromApiEvent extends JokeEvent {
  String searchKeyWord = 'hipster';
  FetchJokesFromApiEvent({
    required this.searchKeyWord,
  });
}

class NavigateToJokeDetailsViewEvent extends JokeEvent {}

// class SearchJokesFromApiEvent extends JokeEvent {
//   String searchKeyWord;
//   SearchJokesFromApiEvent({
//     required this.searchKeyWord,
//   });
// }
