import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lanchonete/models/product_list.dart';
import 'package:lanchonete/models/product.dart';

class ProdutoService extends ChangeNotifier {
  static const apiEndPoint = "http://10.0.2.2:8800/produtos";
  bool isLoading = true;
  String error = '';
  ProductList datumProdutos = ProductList(data: []);

  listarProdutos() async {
    try {
      final response = await http.get(Uri.parse(apiEndPoint));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Produtos> dataList =
            jsonList.map((item) => Produtos.fromMap(item)).toList();
        datumProdutos = ProductList(data: dataList);
        datumProdutos.data.forEach((element) {
          print(element.descricao_longa);
        });
      } else {
        error = 'Erro: ${response.statusCode}';
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
  // Future<List<Map<String, dynamic>>> listarProdutos() async {
  //   const url = "http://10.0.2.2:8800/produtos";
  //   final response = await http.get(Uri.parse(url));

  //   // print(response.body); // Imprime o corpo da resposta para debug

  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonData = jsonDecode(response.body);

  //     // Verifica se jsonData é uma lista de mapas
  //     return jsonData.map((item) => item as Map<String, dynamic>).toList();
  //   } else {
  //     throw Exception('Erro ao listar produtos: ${response.statusCode}');
  //   }
  // }

  Future<String> atualizarProduto(
      int id,
      String nome,
      String descricao,
      String descricao_longa,
      String valor,
      String categoria,
      File? imagem,
      String nome_url,
      String combo,
      String vendas) async {
    final url = "http://10.0.2.2:8800/produtos/$id";
    try {
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.fields['nome'] = nome;
      request.fields['descricao'] = descricao;
      request.fields['descricao_longa'] = descricao_longa;
      request.fields['valor'] = valor;
      request.fields['categoria'] = categoria;
      request.fields['nome_url'] = nome_url;
      request.fields['combo'] = combo;
      request.fields['vendas'] = vendas;
      if (imagem != null) {
        request.files.add(
          await http.MultipartFile.fromPath('imagem', imagem.path),
        );
      } else {
        // Use the existing image path if no new image is selected
        request.fields['imagem'] = 'existing_image_path';
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        listarProdutos();
        notifyListeners();
        return responseData;
      } else {
        var responseData = await response.stream.bytesToString();
        listarProdutos();
        notifyListeners();
        throw Exception('Erro ao cadastrar categoria: $responseData');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar produto: $e');
    }
  }

  Future<String> deletarProduto(int id) async {
    final url = "http://10.0.2.2:8800/produtos/$id";
    try {
      final response = await http.delete(Uri.parse(url));
      print(response.body); // Imprime o corpo da resposta para debug
      listarProdutos();
      notifyListeners();
      return jsonEncode(response.body);
    } catch (e) {
      throw Exception('Erro ao deletar produto: $e');
    }
  }

  Future<List<Map<String, dynamic>>> pesquisarProduto(String searchName) async {
    final url = "http://10.0.2.2:8800/produtos/$searchName";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      print(jsonData);
      return jsonData.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Erro ao listar produtos: ${response.statusCode}');
    }
  }

  Future<String> cadastrarProduto(
      String nome,
      String descricao,
      String descricao_longa,
      String valor,
      String categoria,
      File? imagem,
      String nome_url,
      String combo,
      String vendas) async {
    final url = "http://10.0.2.2:8800/produtos";
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['nome'] = nome;
      request.fields['descricao'] = descricao;
      request.fields['descricao_longa'] = descricao_longa;
      request.fields['valor'] = valor;
      request.fields['categoria'] = categoria;
      request.fields['nome_url'] = nome_url;
      request.fields['combo'] = combo;
      request.fields['vendas'] = vendas;

      if (imagem != null) {
        request.files.add(
          await http.MultipartFile.fromPath('imagem', imagem.path),
        );
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        listarProdutos();
        notifyListeners();
        return responseData;
      } else {
        throw Exception('Erro ao cadastrar produto: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Erro ao cadastrar produto: $e');
    }
  }
}
