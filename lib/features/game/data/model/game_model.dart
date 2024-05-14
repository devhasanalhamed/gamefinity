class GameModel {
  final String name;
  final String imagePath;

  GameModel({
    required this.name,
    required this.imagePath,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      name: json['name'],
      imagePath: json['background_image'],
    );
  }
}
