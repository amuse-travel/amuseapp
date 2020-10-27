import 'package:amuse_app/blocs/product/product_bloc.dart';
import 'package:amuse_app/model/product/product.dart';
import 'package:amuse_app/pages/common/common_widgets/loading_indicator/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AmuseForm extends StatefulWidget {
  @override
  _AmuseFormState createState() => _AmuseFormState();
}

class _AmuseFormState extends State<AmuseForm> {
  ProductBloc _productBloc;

  RefreshController _refreshController;

  List<Product> _productList;

  int _page = 0;

  @override
  void initState() {
    super.initState();

    _productBloc = context.bloc<ProductBloc>();

    _productList = <Product>[];

    _productBloc.add(ProductListLoaded());

    _refreshController = RefreshController();
  }

  @override
  void dispose() {
    _refreshController.dispose();

    super.dispose();
  }

  Future<void> _onRefresh() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _productList.clear();
      _page = 0;
    });
    _productBloc.add(ProductListLoaded());
    _refreshController.refreshCompleted();
  }

  Future<void> _loadMore(int itemCount) async {
    if (itemCount / 10 == _page) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 200));
      setState(() {
        _page++;
        _productBloc.add(ProductListLoaded());
      });
    }
  }

  Future<void> _onLoading() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 100));
    _loadMore(_productList.length);
    _refreshController.loadComplete();
  }

  Widget _shortCategories(int index) {
    if (_productList[index].shortCategories.length > 1) {
      return Row(
        children: <Widget>[
          Text(
            _productList[index].shortCategories[0],
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          for (String shortCategory in _productList[index].shortCategories)
            Text(
              '/$shortCategory',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
        ],
      );
    } else {
      return Text(
        _productList[index].shortCategories[0],
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return BlocConsumer<ProductBloc, ProductState>(
      builder: (BuildContext buildContext, ProductState state) {
        return Container(
          // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          width: _sizeWidth,
          height: _sizeHeight,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  '관광약자를 위한 여행‍',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  header: MaterialClassicHeader(
                    color: Theme.of(context).primaryColorDark,
                    backgroundColor: Colors.white,
                    // offset: 100,
                  ),
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus loadStatus) {
                      if (loadStatus == LoadStatus.loading) {
                        return LoadingIndicator();
                      } else {
                        return const SizedBox(
                          height: 0,
                        );
                      }
                    },
                  ),
                  child: ListView.builder(
                    itemCount: _productList.length,
                    itemBuilder: (BuildContext buildContext, int index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      width: _sizeWidth,
                      height: 320,
                      child: RaisedButton(
                        onPressed: () {},
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        color: Colors.white,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                              child: Container(
                                width: _sizeWidth,
                                height: 200,
                                child: CachedNetworkImage(
                                  imageUrl: _productList[index].image.thumb,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              alignment: Alignment.centerLeft,
                              child: _shortCategories(index),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _productList[index].title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${_productList[index].basePrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},')}원 ~',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      listener: (BuildContext buildContext, ProductState state) {
        if (state is ProductListLoadSuccess) {
          _productList.addAll(state.products);
        }
      },
    );
  }
}
