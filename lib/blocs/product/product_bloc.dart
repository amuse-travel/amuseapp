import 'dart:async';

import 'package:amuse_app/model/product/product.dart';
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
  }

  Stream<ProductState> _mapProductListLoadedToState(ProductListLoaded event) async* {
    yield ProductInProgress();
    try {
      final List<Product> _products = await _productRepository.getProductList();
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
}
