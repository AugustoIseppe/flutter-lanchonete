import 'dart:convert';
import 'package:lanchonete/models/product.dart';

ProductList datumProdutosFromJson(String str) => ProductList.fromJson(json.decode(str));
String datumProdutosToJson(ProductList data) => json.encode(data.toJson());

class  ProductList{

  final List<Produtos> data;
  ProductList({required this.data});

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    data: List<Produtos>.from(json["data"].map((x) => Produtos.fromMap(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
  
}