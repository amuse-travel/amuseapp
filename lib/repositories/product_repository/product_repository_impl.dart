import 'dart:convert';
import 'dart:developer';

import 'package:amuse_app/model/product/product.dart';
import 'package:amuse_app/repositories/product_repository/product_repository.dart';
import 'package:amuse_app/services/dio.dart';
import 'package:dio/dio.dart';

class ProductRepositoryImpl extends ProductRepository {
  final HttpDio _httpDio = HttpDio();

  @override
  Future<List<Product>> getProductList() async {
    try {
      final Response<dynamic> response = await _httpDio.dio().get<dynamic>(
            '/api/products',
          );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.toString())['data'] as List<dynamic>;

        final List<Product> products = jsonResponse.map((dynamic json) => Product.fromJson(json as Map<String, dynamic>)).toList();
        if (products != null) {
          return products;
        } else {
          return null;
        }
      } else {
        log('===| getProductList |=======');
        return null;
      }
    } catch (e) {
      log('===| getProductList |=======[ ${e.toString()}');
      return null;
    }
  }
}
