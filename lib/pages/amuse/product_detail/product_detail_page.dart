import 'package:flutter/material.dart';

import '../../../model/product/product_detail.dart';
import 'product_detail_form.dart';

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
