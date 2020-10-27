class ProductLanguage {
  ProductLanguage({
    this.name,
  });

  ProductLanguage.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
  }

  String name;
}
