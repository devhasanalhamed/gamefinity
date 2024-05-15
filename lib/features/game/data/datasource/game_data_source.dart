import 'package:gamefinity/features/game/data/model/game_model.dart';
import 'package:gamefinity/features/game/data/repository/game_base_repository.dart';

class GameDataSource extends GameBaseRepository {
  @override
  Future<List<GameModel>> fetchGames(Map<String, dynamic> data) {
    // TODO: implement fetchGames
    throw UnimplementedError();
  }
}
