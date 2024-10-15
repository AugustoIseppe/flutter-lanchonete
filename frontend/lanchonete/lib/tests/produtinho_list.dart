import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lanchonete/tests/produtinho.dart';

class ProdutinhoList with ChangeNotifier {
  List<Produtinho> _produtos = [];
  List<Produtinho> get produtos => _produtos;

  Future<void> loadProducts() async {
    _produtos.clear();

    //Requisição GET para obter os produtos!
    final response = await http.get(Uri.parse("http://10.0.2.2:8800/produtos"));
    // if (response.body == "null") return;

    var data = jsonDecode(response.body);
    print(data);

    /* ForEach para percorrer todos os itens da resposta do Firebase("response.body") */
    print(data.runtimeType);
    _produtos.addAll(data.map<Produtinho>((e) => Produtinho.fromMap(e)).toList());
    print('produtos : ${produtos}');
    notifyListeners();
    // return data;
  }
}
