import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lanchonete/models/user.dart';

class UserList extends ChangeNotifier {
  List<User> _users = [];
  List<User> get users => _users;
  bool isLoading = false;
  String error = '';

  Future<void> loadUsers() async {
    _users.clear();
    isLoading = true;

    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:8800/usuarios"));

      var data = jsonDecode(response.body);
      print(data);

      /* ForEach para percorrer todos os itens da resposta do Firebase("response.body") */
      print(data.runtimeType);
      _users.addAll(data.map<User>((e) => User.fromMap(e)).toList());
      for (var user in _users) {
        print(user.nome);
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = 'Erro ao carregar usuários';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
