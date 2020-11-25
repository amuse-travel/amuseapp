import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../blocs/product/product_bloc.dart';
import '../../main.dart';
import '../../model/product/product.dart';
import '../common/common_widgets/loading_indicator/loading_indicator.dart';
import 'product_detail/product_detail_page.dart';

class AmuseForm extends StatefulWidget {
  @override
  _AmuseFormState createState() => _AmuseFormState();
}

class _AmuseFormState extends State<AmuseForm> {
  ProductBloc _productBloc;

  RefreshController _refreshController;

  List<Product> _productList;

  int _page = 1;

  bool _shouldIgnore = false;

  @override
  void initState() {
    super.initState();

    _productBloc = BlocProvider.of<ProductBloc>(context);

    _productList = <Product>[];

    _productBloc.add(ProductListLoaded(page: _page));

    _refreshController = RefreshController();
  }

  @override
  void dispose() {
    _refreshController.dispose();

    super.dispose();
  }

  void _onProductDetailLoad(int productId) {
    _productBloc.add(ProductDetailLoaded(productId: productId));
  }

  Future<void> _onRefresh() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _productList.clear();
      _page = 1;
    });
    _productBloc.add(ProductListLoaded(page: _page));
    _refreshController.refreshCompleted();
  }

  Future<void> _loadMore(int itemCount) async {
    if (itemCount / 10 == _page) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 200));
      setState(() {
        _page++;
        _productBloc.add(ProductListLoaded(page: _page));
      });
    }
  }

  Future<void> _onLoading() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 100));
    _loadMore(_productList.length);
    _refreshController.loadComplete();
  }

  Widget _shortCategories(int index) {
    String _shortCategory = _productList[index].shortCategories[0];
    if (_productList[index].shortCategories.length > 1) {
      for (int i = 1; i < _productList[index].shortCategories.length; i++) {
        _shortCategory += '/' + _productList[index].shortCategories[i];
      }
    }
    return Text(
      _shortCategory,
      style: TextStyle(
        fontSize: 12,
        fontWeight: REGULAR,
        color: Theme.of(context).primaryColorDark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<ProductBloc, ProductState>(
      builder: (BuildContext buildContext, ProductState state) {
        return Stack(
          children: <Widget>[
            IgnorePointer(
              ignoring: _shouldIgnore,
              child: SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                header: MaterialClassicHeader(
                  color: Theme.of(context).accentColor,
                  backgroundColor: Colors.white,
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
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.only(top: 22, bottom: 16, left: 20, right: 20),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            const Text(
                              '관광약자를 위한 여행‍',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: MEDIUM,
                                color: Colors.black,
                              ),
                            ),
                            Image.asset(
                              'assets/icons/emoji.png',
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext buildContext, int index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          child: Container(
                            height: 320,
                            child: RaisedButton(
                              onPressed: () => _onProductDetailLoad(_productList[index].id),
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(14),
                                      topRight: Radius.circular(14),
                                    ),
                                    child: Container(
                                      width: _sizeWidth,
                                      height: 200,
                                      child: CachedNetworkImage(
                                        imageUrl: _productList[index].image.src,
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
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: BOLD,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${_productList[index].basePrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},')}원 부터~',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        childCount: _productList.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state is ProductInProgress) LoadingIndicator(),
          ],
        );
      },
      listener: (BuildContext buildContext, ProductState state) {
        if (state is ProductInProgress) {
          _shouldIgnore = true;
        }
        if (state is ProductListLoadSuccess) {
          _shouldIgnore = false;
          _productList.addAll(state.products);
        }
        if (state is ProductFailure) {
          _shouldIgnore = false;
        }
        if (state is ProductDetailLoadSuccess) {
          _shouldIgnore = false;
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext buildContext) => ProductDetailPage(
                productDetail: state.productDetail,
              ),
            ),
          );
        }
      },
    );
  }
}
