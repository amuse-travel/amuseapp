import 'package:amuse_app/model/custom_image.dart';

class Product {
  Product({
    this.id,
    this.title,
    this.subtitle,
    this.basePrice,
    this.image,
    this.shortCategories,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    title = json['title'] as String;
    title = json['subtitle'] as String;
    basePrice = json['base_price'] as int;
    image = CustomImage.fromJson(json['image'] as Map<String, dynamic>);
    shortCategories = json['shortCategories'] != null ? List<String>.from(json['shortCategories'] as List<dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['basePrice'] = basePrice;
    data['image'] = image;
    data['shortCategories'] = shortCategories;
  }

  int id;
  String title;
  String subtitle;
  int basePrice;
  CustomImage image;
  List<String> shortCategories;
}
