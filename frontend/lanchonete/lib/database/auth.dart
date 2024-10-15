import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lanchonete/utils/store.dart';

class Auth with ChangeNotifier {
  late String usuario;
  late String senha;
  late String nivel;
  late String nome;

  Map<String, dynamic> usuarioLogado = {};
  Future<List<dynamic>> login(String usuario, String senha) async {
    const urlLogin = "http://192.168.1.109:8800/usuarios/login";
    try {
      final response = await http.post(
        Uri.parse(urlLogin),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'usuario': usuario,
          'senha': senha,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        for (var element in jsonData) {
          if (element['usuario'] == usuario && element['senha'] == senha) {
            this.usuario = element['usuario'];
            this.senha = element['senha'];
            nivel = element['nivel'];
            usuarioLogado = element;
            break;
          }
        }

        final storeSaveMap =
            await Store.saveMap('usuarioLogado', usuarioLogado);
        final storeGetMap = await Store.getMap('usuarioLogado');

        debugPrint('USUÁRIO SALVO NO STORE?: $storeSaveMap');
        debugPrint('dados do usuário salvo no store: $storeGetMap');
        debugPrint("DADOS USUARIO: $usuarioLogado");
        debugPrint("DADOS USUÁRIO RUNTIMEYPE: ${usuarioLogado.runtimeType}");
        debugPrint(jsonData.toString());
        return jsonData;
      } else {
        throw Exception('Falha ao fazer login: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Erro ao fazer login FRONTEND: $e');
    }
  }

  Future<Map<String, dynamic>> tryAutoLogin() async {
    final storeGetMap = await Store.getMap('usuarioLogado');
    debugPrint('DADOS DO TRY AUTO LOGIN: $storeGetMap');
    return storeGetMap;
  }

  Future<void> logout() async {
    await Store.remove('usuarioLogado');
    notifyListeners();
  }
}