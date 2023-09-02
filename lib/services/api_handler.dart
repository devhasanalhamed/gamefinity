import 'package:http/http.dart' as http;
import 'dart:convert';

class APIHandler {
  static Future<void> getAllProducts() async {
    const url = 'https://api.escuelajs.co/api/v1/products';
    final response = await http.get(Uri.parse(url));
    print('response: ${jsonDecode(response.body)}');
  }
}
