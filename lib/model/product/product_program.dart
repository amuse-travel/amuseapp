import 'product_item.dart';

class ProductProgram {
  ProductProgram({
    this.day,
    this.title,
    this.items,
  });

  ProductProgram.fromJson(Map<String, dynamic> json) {
    day = json['day'] as int;
    title = json['title'] as String;
    if (json['items'] != null) {
      final List<dynamic> itemList = json['items'] as List<dynamic>;
      items = itemList.map((dynamic parsedJson) => ProductItem.fromJson(parsedJson as Map<String, dynamic>)).toList();
    }
  }

  int day;
  String title;
  List<ProductItem> items;
}
