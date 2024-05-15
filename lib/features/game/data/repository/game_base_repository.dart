import 'package:gamefinity/features/game/data/model/game_model.dart';

abstract class GameBaseRepository {
  Future<List<GameModel>> fetchGames(Map<String, dynamic> data);
}
