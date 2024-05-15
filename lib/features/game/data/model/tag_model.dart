class Tag {
  final int id;
  final String name;
  final String imageBackground;

  Tag({
    required this.id,
    required this.name,
    required this.imageBackground,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      imageBackground: json['image_background'],
    );
  }
}
