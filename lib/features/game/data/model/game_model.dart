class GameModel {
  final int id;
  final String name;
  final String backgroundImage;

  GameModel({
    required this.id,
    required this.name,
    required this.backgroundImage,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      name: json['name'],
      backgroundImage: json['background_image'],
    );
  }

  @override
  String toString() =>
      'GameModel(id: $id, name: $name, backgroundImage: $backgroundImage)';

  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        backgroundImage,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameModel &&
          id == other.id &&
          name == other.name &&
          backgroundImage == other.backgroundImage;
}
