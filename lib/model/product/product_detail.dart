import 'package:amuse_app/model/custom_image.dart';
import 'package:amuse_app/model/product/product.dart';
import 'package:amuse_app/model/product/product_keyword.dart';
import 'package:amuse_app/model/product/product_language.dart';
import 'package:amuse_app/model/product/product_program.dart';
import 'package:amuse_app/model/product/product_service.dart';

class ProductDetail {
  ProductDetail({
    this.product,
    this.images,
    this.fullCategories,
    this.programs,
    this.keywords,
    this.languages,
    this.services,
  });

  ProductDetail.fromJson(Map<String, dynamic> json) {
    product = Product.fromJson(json);
    if (json['images'] != null) {
      final List<dynamic> imageList = json['images'] as List<dynamic>;
      images = imageList.map((dynamic parsedJson) => CustomImage.fromJson(parsedJson as Map<String, dynamic>)).toList();
    }
    fullCategories = json['fullCategories'] != null ? List<String>.from(json['fullCategories'] as List<dynamic>) : null;
    if (json['programs'] != null) {
      final List<dynamic> programList = json['programs'] as List<dynamic>;
      programs = programList.map((dynamic parsedJson) => ProductProgram.fromJson(json['programs'] as Map<String, dynamic>)).toList();
    }
    if (json['keywords'] != null) {
      final List<dynamic> keywordList = json['keywords'] as List<dynamic>;
      keywords = keywordList.map((dynamic parsedJson) => ProductKeyword.fromJson(json['keywords'] as Map<String, dynamic>)).toList();
    }
    if (json['languages'] != null) {
      final List<dynamic> languageList = json['languages'] as List<dynamic>;
      languages = languageList.map((dynamic parsedJson) => ProductLanguage.fromJson(json['languages'] as Map<String, dynamic>)).toList();
    }
    if (json['services'] != null) {
      final List<dynamic> serviceList = json['services'] as List<dynamic>;
      services = serviceList.map((dynamic parsedJson) => ProductService.fromJson(json['services'] as Map<String, dynamic>)).toList();
    }
  }

  Product product;
  List<CustomImage> images;
  List<String> fullCategories;
  List<ProductProgram> programs;
  List<ProductKeyword> keywords;
  List<ProductLanguage> languages;
  List<ProductService> services;
}
