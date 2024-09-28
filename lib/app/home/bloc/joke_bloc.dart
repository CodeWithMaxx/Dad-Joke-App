import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dad_joke/app/home/model/joke_model.dart';
import 'package:http/http.dart' as http;
part 'joke_event.dart';
part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeHomeState> {
  JokeBloc() : super(JokeInitialState()) {
    on<FetchJokesFromApiEvent>(fetchJokesFromApiEvent);
    on<NavigateToJokeDetailsViewEvent>(navigateToJokeDetailsViewEvent);
    // on<SearchJokesFromApiEvent>(searchJokesFromApiEvent);
  }

  FutureOr<void> fetchJokesFromApiEvent(
      FetchJokesFromApiEvent event, Emitter<JokeHomeState> emit) async {
    emit(JokeLoadingState());
    final httpClient = http.Client();
    var url = Uri.parse('https://icanhazdadjoke.com/search?term=${event.searchKeyWord}');
    var response = await httpClient.get(
      url,
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      JokeModel jokeModel = JokeModel.fromJson(decodedResponse);
      emit(JokeLoadedSuccessState(
          jokeDataList: jokeModel.results as List<Results>));
      log(decodedResponse.toString());
    }
  }

  FutureOr<void> navigateToJokeDetailsViewEvent(
      NavigateToJokeDetailsViewEvent event, Emitter<JokeHomeState> emit) {
    emit(NavigateToJokeDetailsViewActionState());
  }

  // FutureOr<void> searchJokesFromApiEvent(SearchJokesFromApiEvent event, Emitter<JokeHomeState> emit)async{
         
  // }
}
