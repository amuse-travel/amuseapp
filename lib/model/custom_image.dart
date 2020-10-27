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

  int id;
  String src;
  String thumb;
}
