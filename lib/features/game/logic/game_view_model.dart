import 'package:flutter/material.dart';
import 'package:gamefinity/features/game/data/repository/game_base_repository.dart';

import '../../../core/enum/request_state.dart';
import '../data/datasource/game_data_source.dart';
import '../data/model/game_model.dart';

class GameViewModel extends ChangeNotifier {
  final GameBaseRepository gameBaseRepository = GameDataSource();

  int page = 1;
  final Set<GameModel> _gameList = {};
  RequestState requestState = RequestState.loading;
  bool fetchGamesListIsBusy = false;
  String fetchGamesListErrorMessage = '';
  Set<GameModel> get gameList => _gameList;

  Future<void> fetchGamesList() async {
    if (fetchGamesListIsBusy) return;
    fetchGamesListIsBusy = true;
    final result = await gameBaseRepository.fetchGames({'page': page});
    if (result.$2 == null) {
      _gameList.addAll({...result.$1});
      page += 1;
      requestState = RequestState.done;
    } else {
      fetchGamesListErrorMessage = result.$2!;
      requestState = RequestState.error;
    }
    fetchGamesListIsBusy = false;
    notifyListeners();
  }
}
