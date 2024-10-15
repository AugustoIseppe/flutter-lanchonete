import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lanchonete/models/user_list.dart';

class UsuarioService {
  late String usuario;
  late String senha;
  late String nivel;
  late String nome;
  Map<String, dynamic> usuarioLogado = {};
  final String defaultImagePath = 'assets/imagens/blank-profile.png';
  UserList userList = UserList();

  /* MÉTODO PARA LISTAR TODOS OS USUÁRIOS */
  Future<List<Map<String, dynamic>>> listarUsuarios() async {
    const url = "http://10.0.2.2:8800/usuarios";
    final response = await http.get(Uri.parse(url));

    // print(response.body); // Imprime o corpo da resposta para debug

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);

      // Verifica se jsonData é uma lista de mapas
      return jsonData.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Erro ao listar usuários: ${response.statusCode}');
    }
  }

  //MÉTODO PARA ATUALIZAR USUÁRIO
  Future<String> atualizarUsuario(
    int id,
    String nome,
    String cpf,
    String telefone,
    String usuario,
    String senha,
    String nivel,
    File? imagem,
  ) async {
    final url = "http://10.0.2.2:8800/usuarios/$id";
    try {
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.fields['nome'] = nome;
      request.fields['cpf'] = cpf;
      request.fields['telefone'] = telefone;
      request.fields['usuario'] = usuario;
      request.fields['senha'] = senha;
      request.fields['nivel'] = nivel;

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
        await userList.loadUsers();
        return responseData;
      } else {
        var responseData = await response.stream.bytesToString();
        await userList.loadUsers();
        throw Exception('Erro ao cadastrar usuário: $responseData');
      }
    } catch (e) {
      userList.loadUsers();
      throw Exception('Erro ao cadastrar usuário: $e');
    }
  }

  // MÉTODO PARA DELETAR USUÁRIO
  Future<String> deletarUsuario(int id) async {
    final url = "http://10.0.2.2:8800/usuarios/$id";
    try {
      final response = await http.delete(Uri.parse(url));
      print(response.body); // Imprime o corpo da resposta para debug
      return jsonEncode(response.body);
    } catch (e) {
      throw Exception('Erro ao deletar produto: $e');
    }
  }

  /* MÉTODO PARA CADASTRAR USUÁRIO */
  Future<String> cadastrarUsuario(String nome, String cpf, String telefone,
      String usuario, String senha, String nivel, File? imagem) async {
    const url = "http://10.0.2.2:8800/usuarios";
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['nome'] = nome;
      request.fields['cpf'] = cpf;
      request.fields['telefone'] = telefone;
      request.fields['usuario'] = usuario;
      request.fields['senha'] = senha;
      request.fields['nivel'] = nivel;

      if (imagem != null) {
        request.files.add(
          await http.MultipartFile.fromPath('imagem', imagem.path),
        );
      }
      var response = await request.send();
      // if (response.statusCode == 200) {
      //   var responseData = await response.stream.bytesToString();
      //   return responseData;
      // } else {
      //   throw Exception('Erro ao cadastrar usuário: ${response.reasonPhrase}');
      // }
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = await response.stream.bytesToString();
        return responseData;
      } else {
        throw Exception('Erro ao cadastrar usuário: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Erro ao cadastrar usuário: $e');
    }
  }
}
