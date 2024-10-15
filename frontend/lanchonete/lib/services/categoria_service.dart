import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lanchonete/models/category.dart';
import 'package:lanchonete/models/category_list.dart';
import 'package:lanchonete/exceptions/http_exception.dart';

class CategoriaService extends ChangeNotifier {
  static const apiEndPoint = "http://10.0.2.2:8800/categorias";
  bool isLoading = true;
  String error = '';
  CategoryList categoryList = CategoryList(data: []);

  listarCategorias() async {
    try {
      final response = await http.get(Uri.parse(apiEndPoint));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Category> dataList =
            jsonList.map((item) => Category.fromMap(item)).toList();
        categoryList = CategoryList(data: dataList);
      } else {
        error = 'Erro: ${response.statusCode}';
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  //   /* MÉTODO PARA LISTAR TODAS AS CATEGORIAS */
  //   Future<List<Map<String, dynamic>>> listarCategorias() async {
  //   const url = "http://10.0.2.2:8800/categorias";
  //   final response = await http.get(Uri.parse(url));

  //   // print(response.body); // Imprime o corpo da resposta para debug

  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonData = jsonDecode(response.body);

  //     // Verifica se jsonData é uma lista de mapas
  //     return jsonData.map((item) => item as Map<String, dynamic>).toList();
  //   } else {
  //     throw Exception('Erro ao listar categorias: ${response.statusCode}');
  //   }
  // }

// MÉTODO PARA CADASTRAR CATEGORIA - Ok
  Future<String> cadastrarCategoria(
    String nome,
    String descricao,
    File? imagem,
    String nome_url,
    String produtos,
  ) async {
    final url = "http://10.0.2.2:8800/categorias";
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['nome'] = nome;
      request.fields['descricao'] = descricao;
      request.fields['nome_url'] = nome_url;
      request.fields['produtos'] = produtos;

      if (imagem != null) {
        request.files.add(
          await http.MultipartFile.fromPath('imagem', imagem.path),
        );
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        var responseData = await response.stream.bytesToString();
        listarCategorias();
        notifyListeners();
        return responseData;
      } else {
        var responseData = await response.stream.bytesToString();
        listarCategorias();
        notifyListeners();
              // Analisando o JSON da resposta para capturar a mensagem de erro
      var responseJson = json.decode(responseData);
      var errorCode = responseJson['details']['code'] ?? 'Erro desconhecido';
      // var errorMessage = responseJson['details']['sqlMessage'] ?? 'Erro desconhecido';
      // error = errorCode;
      // Lançando exceção customizada com a mensagem de erro específica
      throw HttpException(errorCode);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

// MÉTODO PARA ATUALIZAR CATEGORIA
  Future<String> atualizarCategoria(
    int id,
    String nome,
    String descricao,
    File? imagem,
    String nome_url,
    String produtos,
  ) async {
    final url = "http://10.0.2.2:8800/categorias/$id";
    try {
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.fields['nome'] = nome;
      request.fields['descricao'] = descricao;
      request.fields['nome_url'] = nome_url;
      request.fields['produtos'] = produtos;

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
        listarCategorias();
        notifyListeners();
        return responseData;
      } else {
        var responseData = await response.stream.bytesToString();
        listarCategorias();
        notifyListeners();
        throw Exception('Erro ao cadastrar categoria: $responseData');
      }
    } catch (e) {
      throw Exception('Erro ao cadastrar categoria: $e');
    }
  }

  // MÉTODO PARA DELETAR CATEGORIA
  Future<String> deletarCategoria(int id) async {
    final url = "http://10.0.2.2:8800/categorias/$id";
    try {
      final response = await http.delete(Uri.parse(url));
      print(response.body); // Imprime o corpo da resposta para debug
      listarCategorias();
      notifyListeners();
      return jsonEncode(response.body);
    } catch (e) {
      throw Exception('Erro ao deletar produto: $e');
    }
  }
}
