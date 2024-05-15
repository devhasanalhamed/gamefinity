import 'package:gamefinity/features/game/data/model/game_model.dart';

abstract class GameBaseRepository {
  Future<(Set<GameModel>, String?)> fetchGames(Map<String, dynamic> data);
}
