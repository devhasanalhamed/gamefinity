import 'package:dio/dio.dart';
import 'package:gamefinity/core/network/api_constants.dart';
import 'package:gamefinity/core/network/rest_api_service.dart';
import 'package:gamefinity/features/game/data/model/game_model.dart';
import 'package:gamefinity/features/game/data/repository/game_base_repository.dart';

class GameDataSource extends GameBaseRepository {
  final client = RestApiService();

  @override
  Future<(Set<GameModel>, String?)> fetchGames(
      Map<String, dynamic> data) async {
    try {
      final Response result =
          await client.getData('${ApiConstants.games}?page=${data['page']}');
      //Todo: redo the comment
      // .getData('${ApiConstants.games}?page=${data['page'] ?? 1}');
      if (result.statusCode != 200) throw result;

      final responseData = result.data['results'] as List;
      final gamesList =
          responseData.map((game) => GameModel.fromJson(game)).toSet();
      return (gamesList, null);
    } catch (e) {
      return (<GameModel>{}, e.toString());
    }
  }
}
