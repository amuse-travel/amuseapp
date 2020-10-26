import 'package:amuse_app/blocs/product/product_bloc.dart';
import 'package:amuse_app/pages/amuse/amuse_form.dart';
import 'package:amuse_app/repositories/product_repository/product_repository.dart';
import 'package:amuse_app/repositories/product_repository/product_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmusePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ProductRepository>(
      create: (BuildContext buildContext) => ProductRepositoryImpl(),
      child: BlocProvider<ProductBloc>(
        create: (BuildContext buildContext) {
          final ProductRepository _productRepository = RepositoryProvider.of<ProductRepository>(buildContext);
          return ProductBloc(productRepository: _productRepository);
        },
        child: AmuseForm(),
      ),
    );
  }
}
