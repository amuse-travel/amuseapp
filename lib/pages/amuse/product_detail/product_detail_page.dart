import 'package:amuse_app/model/product/product_detail.dart';
import 'package:amuse_app/pages/amuse/product_detail/product_detail_form.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    @required ProductDetail productDetail,
  })  : assert(productDetail != null),
        _productDetail = productDetail;

  final ProductDetail _productDetail;

  @override
  Widget build(BuildContext context) {
    return ProductDetailForm(
      productDetail: _productDetail,
    );
  }
}
