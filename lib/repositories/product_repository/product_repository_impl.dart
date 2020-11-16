import 'dart:convert';
import 'dart:developer';

import 'package:amuse_app/enums/api_url_enum.dart';
import 'package:dio/dio.dart';

import '../../model/product/product.dart';
import '../../model/product/product_detail.dart';
import '../../services/dio.dart';
import 'product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final HttpDio _httpDio = HttpDio(apiUrlEnum: ApiUrlEnum.amuse);

  @override
  Future<List<Product>> getProductList({int page}) async {
    try {
      final Response<dynamic> response = await _httpDio.dio().get<dynamic>(
            '/api/products?page=$page',
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

  @override
  Future<ProductDetail> getProductDetail({int productId}) async {
    try {
      final Response<dynamic> response = await _httpDio.dio().get<dynamic>(
            '/api/products/$productId',
          );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.toString())['data'] as Map<String, dynamic>;
        final ProductDetail productDetail = ProductDetail.fromJson(jsonResponse);

        if (productDetail != null) {
          return productDetail;
        } else {
          return null;
        }
      } else {
        log('===| getProductDetail |=======');
        return null;
      }
    } catch (e) {
      log('===| getProductDetail |=======[ ${e.toString()}');
      return null;
    }
  }
}
