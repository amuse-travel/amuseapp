import 'dart:convert';

import 'package:amuse_app/model/product/product_curation.dart';
import 'package:amuse_app/repositories/product_repository/product_repository.dart';
import 'package:amuse_app/services/dio.dart';
import 'package:dio/dio.dart';

class ProductRepositoryImpl extends ProductRepository {
  final HttpDio _httpDio = HttpDio();

  @override
  Future<List<ProductCuration>> getProductList() async {
    try {
      final Response<dynamic> response = await _httpDio.dio().get<dynamic>(
            '/api/products/curation',
          );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.toString()) as List<dynamic>;
        final List<ProductCuration> productCurations = jsonResponse.map((dynamic json) => ProductCuration.fromJson(json as Map<String, dynamic>)).toList();

        if(productCurations != null) {
          return productCurations;
        } else {
          return null;
        }
      }
    } catch (e) {
      print('===| getProductList |=======[ ${e.toString()}');
      return null;
    }
  }
}
