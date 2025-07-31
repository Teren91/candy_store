import 'dart:convert';

import 'package:candy_store/product_list_item.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final String _baseUrl = 'https://api.example.com/candystore';

  Future<List<ProductListItem>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));

    if(response.statusCode == 200) {
      final List<dynamic> productData = json.decode(response.body);
      return productData.map((json) => ProductListItem.fromJson(json))
        .toList();
    }else {
      throw Exception('Failed to load candies');
    }
  }
}