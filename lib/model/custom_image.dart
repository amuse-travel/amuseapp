class CustomImage {
  CustomImage({
    this.id,
    this.src,
    this.thumb,
  });

  CustomImage.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    src = json['src'] as String;
    thumb = json['thumb'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['src'] = src;
    data['thumb'] = thumb;
  }

  int id;
  String src;
  String thumb;
}
