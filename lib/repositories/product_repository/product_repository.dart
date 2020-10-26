import 'package:amuse_app/model/product/product_curation.dart';

abstract class ProductRepository {
  Future<List<ProductCuration>> getProductList();
}
