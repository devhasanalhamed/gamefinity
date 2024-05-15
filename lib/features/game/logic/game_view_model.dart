import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data/model/game_model.dart';

class GameViewModel extends ChangeNotifier {
  List<GameModel> gameList = [];

  Future<void> getGameList() async {
    print("heel");
    final dio = Dio();

    final result = await dio.get('https://api.rawg.io/api/games?key=');

    final responseData = result.data['results'] as List;
    gameList.addAll(
      responseData.map(
        (game) => GameModel.fromJson(game),
      ),
    );

    notifyListeners();
  }
}
