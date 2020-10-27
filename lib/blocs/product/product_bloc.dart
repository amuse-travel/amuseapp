import 'dart:async';

import 'package:amuse_app/model/product/product.dart';
import 'package:amuse_app/model/product/product_detail.dart';
import 'package:amuse_app/repositories/product_repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    @required ProductRepository productRepository,
  })  : assert(productRepository != null),
        _productRepository = productRepository,
        super(ProductInitial());

  final ProductRepository _productRepository;

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductListLoaded) {
      yield* _mapProductListLoadedToState(event);
    }
    if (event is ProductDetailLoaded) {
      yield* _mapProductDetailLoadedToState(event);
    }
  }

  Stream<ProductState> _mapProductListLoadedToState(ProductListLoaded event) async* {
    yield ProductInProgress();
    try {
      final List<Product> _products = await _productRepository.getProductList(page: event.page);
      if (_products != null) {
        yield ProductListLoadSuccess(products: _products);
      } else {
        yield ProductFailure();
      }
    } catch (e) {
      print('===| _mapProductListLoadedToState |=======[${e.toString()}');
      yield ProductFailure();
    }
  }

  Stream<ProductState> _mapProductDetailLoadedToState(ProductDetailLoaded event) async* {
    yield ProductInProgress();
    try {
      final ProductDetail _productDetail = await _productRepository.getProductDetail(productId: event.productId);
      if (_productDetail != null) {
        yield ProductDetailLoadSuccess(productDetail: _productDetail);
      } else {
        yield ProductFailure();
      }
    } catch (e) {
      print('===| _mapProductDetailLoadedToState |=======[${e.toString()}');
      yield ProductFailure();
    }
  }
}
