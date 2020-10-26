part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => <Object>[];
}

class ProductInitial extends ProductState {}

class ProductInProgress extends ProductState {}

class ProductFailure extends ProductState {}

class ProductListLoadSuccess extends ProductState {
  const ProductListLoadSuccess({
    @required this.productCurations,
  }) : assert(productCurations != null);

  final List<ProductCuration> productCurations;

  @override
  List<Object> get props => <Object>[productCurations];
}
