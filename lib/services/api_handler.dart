import 'package:gamefinity/consts/api_consts.dart';
import 'package:gamefinity/models/category_model.dart';
import 'package:gamefinity/models/products_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIHandler {
  static Future<List<ProductsModel>> getAllProducts() async {
    final uri = Uri.https(BASE_URL, 'api/v1/products');
    final response = await http.get(uri);
    final responseData = jsonDecode(response.body);
    List temp = [];
    for (var value in responseData) {
      temp.add(value);
    }
    return ProductsModel.productsFromSnapshot(temp);
  }

  static Future<List<CategoriesModel>> getCategories() async {
    final uri = Uri.https(BASE_URL, 'api/v1/categories');
    final response = await http.get(uri);
    final responseData = jsonDecode(response.body);
    List temp = [];
    for (var value in responseData) {
      temp.add(value);
    }
    return CategoriesModel.categoriesFromSnapshot(temp);
  }
}
