import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lanchonete/services/categoria_service.dart';
import 'dart:io';

class CadastrarCategoria extends StatefulWidget {
  @override
  _CadastrarCategoriaState createState() => _CadastrarCategoriaState();
}

class _CadastrarCategoriaState extends State<CadastrarCategoria> {
  final _formKey = GlobalKey<FormState>();
  final _nomeProdutoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _imagemController = TextEditingController();
  final _nomeUrlController = TextEditingController();
  final _produtosController = TextEditingController();

  File? _selectedImage;

  void _clearFields() {
    _nomeProdutoController.clear();
    _descricaoController.clear();
    _imagemController.clear();
    _nomeUrlController.clear();
    _produtosController.clear();
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
        CategoriaService categoriaService = CategoriaService();
        categoriaService.cadastrarCategoria(
          _nomeProdutoController.text,
          _descricaoController.text,
          _selectedImage,
          _nomeUrlController.text,
          _produtosController.text,
        ).then((response) {
          // Sucesso no cadastro
          _showDialog('Cadastro de Categoria', 'Categoria cadastrada com sucesso!', true);
        }).catchError((error) {
          // Erro no cadastro
          String errorMessage;
          if (error is HttpException) {
            errorMessage = error.toString();
          } else {
            errorMessage = "Valor inválido";
          }
          _showDialog('Cadastro de Categoria', errorMessage, false);
          // print(error);
        });
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cadastro de Categoria'),
            content: Text('Erro ao cadastrar categoria: $e'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Categoria - Admin', style: GoogleFonts.lato(
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
              TextFormField(
                controller: _nomeProdutoController,
                decoration: InputDecoration(
                  labelText: 'Nome da Categoria',
                  labelStyle: const TextStyle(color: Color(0xff6f1610)),
                  fillColor: const Color(0xfffff9e6),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da Categoria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  labelStyle: const TextStyle(color: Color(0xff6f1610)),
                  fillColor: const Color(0xfffff9e6),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição da Categoria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nomeUrlController,
                decoration: InputDecoration(
                  labelText: 'Nome URL',
                  labelStyle: const TextStyle(color: Color(0xff6f1610)),
                  fillColor: const Color(0xfffff9e6),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor do Categoria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _produtosController,
                decoration: InputDecoration(
                  labelText: 'Produtos',
                  labelStyle: const TextStyle(color: Color(0xff6f1610)),
                  fillColor: const Color(0xfffff9e6),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade de produtos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              _selectedImage != null ? 
                InkWell(
                  onTap: _pickImage,
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.file(_selectedImage!, height: 200, fit: BoxFit.cover,)),
                  ),
                ) : InkWell(
                  onTap: _pickImage,
                  child: const SizedBox(
                    height: 200,
                    width: 200,
                    child: Card(
                      color: Colors.white,
                      child: Icon(Icons.add_a_photo, size: 50, color: Colors.grey)),
                  ),
                ),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6f1610),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('Cadastrar Categoria', style: GoogleFonts.lato(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                ),),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xfffff9e6),
    );
  }
}
