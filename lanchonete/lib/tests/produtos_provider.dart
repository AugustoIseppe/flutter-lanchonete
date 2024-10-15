// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:lanchonete/tests/produtos_teste.dart';

// class ProdutosProvider extends ChangeNotifier {
//   static const apiEndPoint = "http://10.0.2.2:8800/produtos";
//   bool isLoading = true;
//   String error = '';
//   TesteProdutos testeProdutos = TesteProdutos(data: []);

//   getDataFromApi() async {
//     try {
//       Response response = await get(Uri.parse(apiEndPoint));
//       if (response.statusCode == 200) {
//         // Se a resposta for uma lista de objetos
//         List<dynamic> jsonList = jsonDecode(response.body);
//         List<Datum> dataList = jsonList.map((item) => Datum.fromMap(item)).toList();
//         testeProdutos = TesteProdutos(data: dataList);
//       } else {
//         error = response.statusCode.toString();
//       }
//     } catch (e) {
//       error = e.toString();
//     }
//     isLoading = false;
//     notifyListeners();
//   }
// }
