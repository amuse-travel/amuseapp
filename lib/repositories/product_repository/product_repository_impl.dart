import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

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
        final List<dynamic> jsonResponse = response as List<dynamic>;
        final List<ProductCuration> productCurations = jsonResponse.map((dynamic index) => ProductCuration.fromJson(index as Map<String, dynamic>)).toList();
        // final Map<String, dynamic> jsonResponse = jsonDecode(response.data[0].toString()) as Map<String, dynamic>;
        // final List<ProductCuration> productCurations = jsonResponse.map((dynamic json) => ProductCuration.fromJson(json as Map<String, dynamic>)).toList();

        // if(productCurations != null) {
        //   return productCurations;
        // } else {
        //   return null;
        // }
        return null;
      } else {
        print('///');
        return null;
      }
    } catch (e) {
      log('===| getProductList |=======[ ${e.toString()}');
      return null;
    }
  }
}
