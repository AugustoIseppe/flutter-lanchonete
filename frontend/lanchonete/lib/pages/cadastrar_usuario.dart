import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:lanchonete/services/usuario_service.dart';
import 'package:lanchonete/utils/easy_colors.dart';

class CadastrarUsuario extends StatefulWidget {
  @override
  _CadastrarUsuarioState createState() => _CadastrarUsuarioState();
}

class _CadastrarUsuarioState extends State<CadastrarUsuario> {
  final _formKey = GlobalKey<FormState>();
  final _nomeUsuarioController = TextEditingController();
  final _cpfUsuarioController = TextEditingController();
  final _telefoneUsuarioController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nivelController = TextEditingController();

  File? _selectedImage;

  void _clearFields() {
    _nomeUsuarioController.clear();
    _cpfUsuarioController.clear();
    _telefoneUsuarioController.clear();
    _usuarioController.clear();
    _senhaController.clear();
    _nivelController.clear();
    setState(() {
      _selectedImage = null;
    });
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Erro ao selecionar imagem: $e");
    }
  }

  void _submitForm() {
  try {
    if (_formKey.currentState!.validate()) {
      UsuarioService usuarioService = UsuarioService();
      usuarioService.cadastrarUsuario(
        _nomeUsuarioController.text,
        _cpfUsuarioController.text,
        _telefoneUsuarioController.text,
        _usuarioController.text,
        _senhaController.text,
        _nivelController.text,
        _selectedImage,
      ).then((response) {
        // Sucesso no cadastro
        _showDialog('Cadastro de Usuário', 'Usuário cadastrado com sucesso!', true);
      }).catchError((error) {
        // Erro no cadastro
        _showDialog('Cadastro de Usuário', 'Erro ao cadastrar usuário!', false);
      });
    }
  } catch (e) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cadastro de Usuário'),
            content: Text('Erro ao cadastrar usuário: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
  }
}

  void _showDialog(String title, String content, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          backgroundColor: const Color(0xfffff9e6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          titleTextStyle: const TextStyle(
            color: Color(0xff6f1610),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: const TextStyle(
            color: Color(0xff6f1610),
            fontSize: 16,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isSuccess) _clearFields(); // Limpa os campos se for sucesso
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff6f1610),
                foregroundColor: Colors.white,
              ),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    EasyColors easyColors = EasyColors();
    return Scaffold(
      backgroundColor: easyColors.secondaryColor,
      appBar: AppBar(
        title: Text('Cadastro de Usuário - Admin', style: GoogleFonts.lato(
          textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),),
        centerTitle: true,
        backgroundColor: const Color(0xff6f1610),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _selectedImage != null ? 
                InkWell(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(_selectedImage!),
                    child: Text('')
                  ),
                ) : InkWell(
                  onTap: _pickImage,
                  child: const SizedBox(
                    child: CircleAvatar(
                      radius: 80,
                      child: Icon(Icons.person, size: 100 ,color: Colors.grey)),
                  ),
                ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nomeUsuarioController,
                decoration: InputDecoration(
                  labelText: 'Nome do Usuário',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do usuário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _cpfUsuarioController,
                decoration: InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o cpf do usuário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _telefoneUsuarioController,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone do usuário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  labelText: 'Usuário(E-mail)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o usuário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite sua senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nivelController,
                decoration: InputDecoration(
                  labelText: 'Nivel',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nivel do usuário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6f1610),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('Cadastrar Usuário', style: GoogleFonts.lato(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
