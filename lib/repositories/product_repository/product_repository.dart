import 'package:amuse_app/model/product/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductList({int page});
}
