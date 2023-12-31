import 'package:gamefinity/core/consts/api_consts.dart';
import 'package:gamefinity/mvc/models/categories_model.dart';
import 'package:gamefinity/mvc/models/products_model.dart';
import 'package:gamefinity/mvc/models/users_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIHandler {
  static Future<List<dynamic>> getData({
    required String target,
    String? limit,
  }) async {
    try {
      final uri = Uri.https(
        BASE_URL,
        "api/v1/$target",
        target == 'products'
            ? {
                'offset': '0',
                'limit': limit,
              }
            : {},
      );
      final response = await http.get(uri);

      final responseData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw responseData['message'];
      }
      List temp = [];
      for (var value in responseData) {
        temp.add(value);
      }

      return temp;
    } catch (error) {
      print('an error occured while getting product info $error');
      throw '$error';
    }
  }

  static Future<List<ProductsModel>> getAllProducts(
      {required String limit}) async {
    final temp = await getData(target: 'products', limit: limit);
    return ProductsModel.productsFromSnapshot(temp);
  }

  static Future<List<CategoriesModel>> getCategories() async {
    final temp = await getData(target: 'categories');
    return CategoriesModel.categoriesFromSnapshot(temp);
  }

  static Future<List<UsersModel>> getUsers() async {
    final temp = await getData(target: 'users');
    return UsersModel.usersFromSnapshot(temp);
  }

  static Future<ProductsModel> getProductByID({required String id}) async {
    try {
      final uri = Uri.https(BASE_URL, "api/v1/products/$id");
      final response = await http.get(uri);

      final responseData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw responseData['message'];
      }
      return ProductsModel.fromJson(responseData);
    } catch (error) {
      print('an error occured while getting product info $error');
      throw '$error';
    }
  }
}
