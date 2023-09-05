import 'package:gamefinity/consts/api_consts.dart';
import 'package:gamefinity/models/categories_model.dart';
import 'package:gamefinity/models/products_model.dart';
import 'package:gamefinity/models/users_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIHandler {
  static Future<List<dynamic>> getData({required String target}) async {
    final uri = Uri.https(BASE_URL, "api/v1/$target");
    final response = await http.get(uri);

    final responseData = jsonDecode(response.body);
    List temp = [];
    for (var value in responseData) {
      temp.add(value);
    }

    return temp;
  }

  static Future<List<ProductsModel>> getAllProducts() async {
    final temp = await getData(target: 'products');
    return ProductsModel.productsFromSnapshot(temp);
  }

  static Future<List<CategoriesModel>> getCategories() async {
    final temp = await getData(target: 'categories');
    return CategoriesModel.categoriesFromSnapshot(temp);
  }

  static Future<List<UsersModel>> getUsers() async {
    final temp = await getData(target: 'users');
    print(temp);
    return UsersModel.usersFromSnapshot(temp);
  }
}
