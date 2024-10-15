
import 'dart:convert';

import 'package:lanchonete/models/category.dart';

CategoryList categoryListFromJson(String str) {
  final jsonData = json.decode(str);
  return CategoryList.fromJson(jsonData);
}

String categoryListToJson(CategoryList data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}


class CategoryList {

  final List<Category> data;
  CategoryList({required this.data});

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    data: List<Category>.from(json["data"].map((x) => Category.fromMap(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
  
}