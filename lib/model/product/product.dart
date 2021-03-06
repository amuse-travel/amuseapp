import '../custom_image.dart';

class Product {
  Product({
    this.id,
    this.title,
    this.subtitle,
    this.basePrice,
    this.duration,
    this.tripPace,
    this.departure,
    this.image,
    this.shortCategories,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    title = json['title'] as String;
    subtitle = json['subtitle'] as String;
    basePrice = json['base_price'] as int;
    duration = json['duration'] as String;
    tripPace = json['trip_pace'] as String;
    departure = json['departure'] as String;
    image = CustomImage.fromJson(json['image'] as Map<String, dynamic>);
    shortCategories = json['shortCategories'] != null ? List<String>.from(json['shortCategories'] as List<dynamic>) : null;
  }

  int id;
  String title;
  String subtitle;
  int basePrice;
  String duration;
  String tripPace;
  String departure;
  CustomImage image;
  List<String> shortCategories;
}
