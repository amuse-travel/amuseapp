class ServiceDetail {
  ServiceDetail({
    this.name,
  });

  ServiceDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
  }

  String name;
}
