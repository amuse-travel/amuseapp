import 'package:amuse_app/model/product/product.dart';

class ProductList {
  ProductList(
    this.keyword,
    this.products,
  );

  ProductList.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      final List<dynamic> productList = json['products'] as List<dynamic>;
      products = productList.map((dynamic index) => Product.fromJson(index as Map<String, dynamic>)).toList();
    }
  }

  String keyword;
  List<Product> products;
}
