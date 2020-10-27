part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => <Object>[];
}

class ProductListLoaded extends ProductEvent {
  const ProductListLoaded({
    @required this.page,
  }) : assert(page != null);

  final int page;
}
