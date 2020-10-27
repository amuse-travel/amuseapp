import 'package:amuse_app/model/custom_image.dart';

class ProductItem {
  ProductItem({
    this.title,
    this.image,
  });

  ProductItem.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    image = json['image'] != null ? CustomImage.fromJson(json['image'] as Map<String, dynamic>) : null;
  }

  String title;
  CustomImage image;
}
