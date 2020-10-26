import 'package:amuse_app/blocs/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmuseForm extends StatefulWidget {
  @override
  _AmuseFormState createState() => _AmuseFormState();
}

class _AmuseFormState extends State<AmuseForm> {

  @override
  void initState() {
    super.initState();

    context.bloc<ProductBloc>().add(ProductListLoaded());
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (BuildContext buildContext, ProductState state) {
        if(state is ProductListLoadSuccess) {
          print('ddd');
        }
      },
      child: Container(
        color: Colors.red,
      ),
    );
  }
}
