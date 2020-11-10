import '../../model/product/product.dart';
import '../../model/product/product_detail.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductList({int page});

  Future<ProductDetail> getProductDetail({int productId});
}
