import 'package:amuse_app/model/product/service_detail.dart';

class ProductService {
  ProductService({
    this.name,
    this.serviceDetails,
  });

  ProductService.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    if (json['items'] != null) {
      final List<dynamic> itemList = json['items'] as List<dynamic>;
      serviceDetails = itemList.map((dynamic parsedJson) => ServiceDetail.fromJson(parsedJson as Map<String, dynamic>)).toList();
    }
  }

  String name;
  List<ServiceDetail> serviceDetails;
}
