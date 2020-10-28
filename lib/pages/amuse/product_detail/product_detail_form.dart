import 'package:amuse_app/main.dart';
import 'package:amuse_app/model/product/product_detail.dart';
import 'package:amuse_app/model/product/product_keyword.dart';
import 'package:amuse_app/pages/common/common_widgets/custom_toast/custom_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailForm extends StatefulWidget {
  const ProductDetailForm({
    @required ProductDetail productDetail,
  })  : assert(productDetail != null),
        _productDetail = productDetail;

  final ProductDetail _productDetail;

  @override
  _ProductDetailFormState createState() => _ProductDetailFormState();
}

class _ProductDetailFormState extends State<ProductDetailForm> {
  ProductDetail _productDetail;

  final Map<String, Icon> _serviceIcons = const <String, Icon>{
    '숙박': Icon(
      Icons.hotel,
    ),
    '항공': Icon(
      Icons.flight,
    ),
    '교통/기사': Icon(
      Icons.directions_bus,
    ),
    '식사': Icon(
      Icons.restaurant,
    ),
    '티켓': Icon(
      Icons.confirmation_num,
    ),
    '가이드': Icon(
      Icons.assignment_ind,
    ),
    '기타서비스': Icon(
      Icons.local_florist,
    ),
  };

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _productDetail = widget._productDetail;
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  Future<void> _onMakePhoneCall() async {
    if (await canLaunch('tel://02-719-6814')) {
      launch('tel://02-719-6814');
    } else {
      CustomToast(message: '전화를 걸 수 없습니다.').show();
    }
  }

  Widget _imageSlider() {
    return Stack(
      children: <Widget>[
        CarouselSlider.builder(
          itemCount: _productDetail.images.length,
          itemBuilder: (BuildContext buildContext, int index) {
            return CachedNetworkImage(
              imageUrl: _productDetail.images[index].src,
              fit: BoxFit.cover,
            );
          },
          options: CarouselOptions(
            initialPage: 0,
            viewportFraction: 1,
            aspectRatio: 1,
            enableInfiniteScroll: true,
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomCenter,
          child: AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: _productDetail.images.length,
            effect: ScrollingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              dotColor: Theme.of(context).secondaryHeaderColor,
              activeDotColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _location() {
    String _categories = _productDetail.fullCategories[0];
    if (_productDetail.fullCategories.length > 1) {
      for (int i = 1; i < _productDetail.fullCategories.length; i++) {
        _categories += '>' + _productDetail.fullCategories[i];
      }
    }

    return Row(
      children: <Widget>[
        Icon(
          Icons.room,
          size: 14,
          color: Theme.of(context).primaryColorDark,
        ),
        Text(
          _categories,
          style: TextStyle(
            fontSize: 12,
            fontWeight: REGULAR,
            color: Theme.of(context).primaryColorDark,
          ),
        )
      ],
    );
  }

  Widget _hashTag() {
    String _hashTags = '';
    for (final ProductKeyword _keyword in _productDetail.keywords) {
      _hashTags += '#' + _keyword.name + ' ';
    }
    return Text(
      _hashTags,
      style: TextStyle(
        fontSize: 14,
        fontWeight: REGULAR,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _informationGrid() {
    String _services = _productDetail.services[0].name;

    if (_productDetail.services.length > 1) {
      for (int i = 1; i < _productDetail.services.length; i++) {
        _services += ', ' + _productDetail.services[i].name;
      }
    }

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.1,
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '출발지',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: MEDIUM,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                _productDetail.product.departure,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: REGULAR,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '진행시간',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: MEDIUM,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                _productDetail.product.duration,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: REGULAR,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '포함사항',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: MEDIUM,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                _services,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: REGULAR,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '활동 강도',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: MEDIUM,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                _productDetail.product.tripPace,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: REGULAR,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '제공언어',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: MEDIUM,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                _productDetail.languages[0].name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: REGULAR,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _travelPrograms() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _productDetail.programs.length,
      itemBuilder: (BuildContext dayContext, int day) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                '${_productDetail.programs[day].day}일차',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: BOLD,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 165,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: _productDetail.programs[day].items.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            width: 100,
                            height: 100,
                            child: _productDetail.programs[day].items[index].image != null
                                ? CachedNetworkImage(
                                    imageUrl: _productDetail.programs[day].items[index].image.thumb,
                                  )
                                : Container(
                                    color: Theme.of(context).primaryColor,
                                    child: Image.asset(
                                      'assets/icons/amuse-mark.png',
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 100,
                          child: Text(
                            _productDetail.programs[day].items[index].title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: MEDIUM,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _servicesDetail() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _productDetail.services.length,
      itemBuilder: (BuildContext buildContext, int index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          child: Row(
            children: <Widget>[
              Icon(
                _serviceIcons[_productDetail.services[index].name].icon,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                _productDetail.services[index].serviceDetails[0].name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: REGULAR,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _productDetail.product.title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: MEDIUM,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: _onBackButtonPressed,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          width: _sizeWidth,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: _sizeWidth,
                  height: _sizeWidth,
                  child: _imageSlider(),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: _location(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _productDetail.product.subtitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: BOLD,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: _hashTag(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${_productDetail.product.basePrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},')}원 ~',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: BOLD,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Divider(
                  color: Theme.of(context).primaryColorDark,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.topCenter,
                  width: _sizeWidth,
                  child: _informationGrid(),
                ),
                const SizedBox(
                  height: 30,
                ),
                Divider(
                  color: Theme.of(context).primaryColorDark,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '📅여행 일정표',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: MEDIUM,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  width: _sizeWidth,
                  child: _travelPrograms(),
                ),
                Divider(
                  color: Theme.of(context).primaryColorDark,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '📌포함사항',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: MEDIUM,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  width: _sizeWidth,
                  child: _servicesDetail(),
                ),
                const SizedBox(
                  height: 30,
                ),
                Divider(
                  color: Theme.of(context).primaryColorDark,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '‼️유의사항-취소/환불',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: MEDIUM,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      width: _sizeWidth,
                      child: Text(
                        '국내여행 취소시 국내여행표준약관 제 13조 소비자분쟁해결규정에 따라 아래의 비율로 취소료가 부과됩니다. (단, 당사의 귀책사유로 여행출발 취소 경우에도 동일한 규정이 적용됩니다.)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: REGULAR,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      width: _sizeWidth,
                      child: Text(
                        '여행개시 15일전까지 통보시: 계약금 환급\n여행개시 14일전까지 통보시: 상품가격의 20% 배상\n여행개시 10일전까지 통보시: 상품가격의 30% 배상\n여행개시 7일전까지 통보시: 상품가격의 50% 배상\n여행개시 5일전까지 통보시: 상품가격의 70% 배상\n여행개시 3일전까지 통보시: 상품가격의 80% 배상\n여행 당일 통보시: 총상품가격의 90% 배상',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: REGULAR,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      width: _sizeWidth,
                      child: Text(
                        '상품 설명내에 취소/환불에 관한 규정이 있는 경우 어뮤즈트래블 취소/환불 규정보다 우선 적용됩니다.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: REGULAR,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Divider(
                  color: Theme.of(context).primaryColorDark,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '📞견적 문의하기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: MEDIUM,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: _sizeWidth,
                  height: 54,
                  child: RaisedButton(
                    onPressed: _onMakePhoneCall,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.all(0),
                    elevation: 0,
                    color: Theme.of(context).primaryColor,
                    child: const Text(
                      '담당자와 전화 상담',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: REGULAR,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
