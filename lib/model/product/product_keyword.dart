class ProductKeyword {
  ProductKeyword({
    this.name,
  });

  ProductKeyword.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
  }

  String name;
}
