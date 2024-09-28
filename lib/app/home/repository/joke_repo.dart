import 'dart:convert';
import 'dart:developer';

import 'package:dad_joke/app/home/model/joke_model.dart';
import 'package:http/http.dart' as http;


class JokeRepository {
  Future<List<JokeModel>> JokesList() async {
    List<JokeModel> jokes = [];
    final httpClient = http.Client();
    var url = Uri.parse('https://icanhazdadjoke.com/search?term=hipster');
    var response = await httpClient.get(
      url,
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      JokeModel jokeModel = JokeModel.fromJson(decodedResponse);
      log(decodedResponse.toString());
      jokes.add(jokeModel);
    }
    return jokes;
  }
}
