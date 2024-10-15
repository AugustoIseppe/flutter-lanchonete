import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lanchonete/services/usuario_service.dart';
import 'package:lanchonete/utils/easy_colors.dart';

class EditarUsuarioPage extends StatefulWidget {
  final Map<String, dynamic> usuario;
  const EditarUsuarioPage({
    super.key,
    required this.usuario,
  });

  @override
  State<EditarUsuarioPage> createState() => _EditarUsuarioPageState();
}

class _EditarUsuarioPageState extends State<EditarUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _cpfController;
  late TextEditingController _telefoneController;
  late TextEditingController _usuarioController;
  late TextEditingController _senhaController;
  late TextEditingController _nivelController;
  late TextEditingController _imagemController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.usuario['nome']);
    _cpfController = TextEditingController(text: widget.usuario['cpf']);
    _telefoneController = TextEditingController(text: widget.usuario['telefone']);
    _usuarioController = TextEditingController(text: widget.usuario['usuario']);
    _senhaController = TextEditingController(text: widget.usuario['senha']);
    _nivelController = TextEditingController(text: widget.usuario['nivel']);
    _imagemController = TextEditingController(text: widget.usuario['imagem']);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _usuarioController.dispose();
    _senhaController.dispose();
    _nivelController.dispose();
    _imagemController.dispose();
    super.dispose();
  }

    Future<void> _pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Erro ao selecionar imagem: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    EasyColors easyColors = EasyColors();
    print(widget.usuario);
    print(_selectedImage.toString());

    return Scaffold(
      backgroundColor: easyColors.secondaryColor,
      appBar: AppBar(
        title: Text(
          widget.usuario['nome'],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: easyColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _selectedImage == null
                  ? CircleAvatar(
                      minRadius: 80,
                      backgroundImage: NetworkImage(
                          'http://10.0.2.2:8800/usuarios/uploads/${widget.usuario['imagem']}'),
                      child: const Text(''))
                  : CircleAvatar(
                      minRadius: 80,
                      backgroundImage: FileImage(_selectedImage!),
                      child: const Text(''),
                    ),
              const SizedBox(height: 10),
              _buildTextField(
                'Nome',
                _nomeController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'CPF',
                _cpfController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Telefone',
                _telefoneController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Usuário (E-mail)',
                _usuarioController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Senha',
                _senhaController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Nível',
                _nivelController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Imagem',
                _imagemController,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text(
                    'Atualizar Imagem',
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: easyColors.primaryColor,
                    padding: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: easyColors.primaryColor,
                    padding: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Implementar a lógica de atualização aqui
                      UsuarioService usuarioService = UsuarioService();
                      usuarioService
                          .atualizarUsuario(
                        widget.usuario['id'],
                        _nomeController.text,
                        _cpfController.text,
                        _telefoneController.text,
                        _usuarioController.text,
                        _senhaController.text,
                        _nivelController.text,
                        _selectedImage ?? File(widget.usuario['imagem']),
                      )
                          .then((response) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: Text(
                                'Atualização de Usuario',
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.displayLarge,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const SizedBox(height: 10),
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green[900],
                                    size: 48,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Usuario atualizado com sucesso!',
                                    style: GoogleFonts.poppins(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Color.fromRGBO(153, 44, 75, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }).catchError((error) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: Text(
                                'Atualização de Usuario',
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.displayLarge,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const SizedBox(height: 10),
                                  Icon(
                                    Icons.error,
                                    color: Colors.red[900],
                                    size: 48,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Erro ao atualizar Usuario!',
                                    style: GoogleFonts.poppins(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Color.fromRGBO(153, 44, 75, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String labelText,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color.fromRGBO(153, 44, 75, 1)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(153, 44, 75, 1),
          ),
        ),
      ),
    );
  }
}
