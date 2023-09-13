import 'package:flutter/material.dart';

class UsersModel with ChangeNotifier {
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;
  DateTime? creationAt;
  DateTime? updatedAt;

  UsersModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    required this.creationAt,
    required this.updatedAt,
  });

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    password = json["password"];
    name = json["name"];
    role = json["role"];
    avatar = json["avatar"];
    creationAt = DateTime.parse(json["creationAt"]);
    updatedAt = DateTime.parse(json["updatedAt"]);
  }

  static List<UsersModel> usersFromSnapshot(List userSnapshot) {
    return userSnapshot
        .map((singleUser) => UsersModel.fromJson(singleUser))
        .toList();
  }
}
