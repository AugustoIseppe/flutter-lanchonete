import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lanchonete/services/categoria_service.dart';
import 'package:lanchonete/utils/easy_colors.dart';

class EditarCategoriaPage extends StatefulWidget {
  final Map<String, dynamic> categoria;
  const EditarCategoriaPage({
    super.key,
    required this.categoria,
  });

  @override
  State<EditarCategoriaPage> createState() => _EditarCategoriaPageState();
}

class _EditarCategoriaPageState extends State<EditarCategoriaPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _descricaoController;
  late TextEditingController _imagemController;
  late TextEditingController _nomeUrlController;
  late TextEditingController _produtosController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.categoria['nome']);
    _descricaoController =
        TextEditingController(text: widget.categoria['descricao']);
    _imagemController = TextEditingController(text: widget.categoria['imagem']);
    _nomeUrlController =
        TextEditingController(text: widget.categoria['nome_url']);
    _produtosController =
        TextEditingController(text: widget.categoria['produtos'].toString());
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _imagemController.dispose();
    _nomeUrlController.dispose();
    _produtosController.dispose();
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
    return Scaffold(
      backgroundColor: easyColors.secondaryColor,
      appBar: AppBar(
        title: Text(
          'Categoria: ${widget.categoria['nome']}',
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
                  ? Center(
                    child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.transparent,
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'http://10.0.2.2:8800/categorias/uploads/${widget.categoria['imagem']}',
                              ),
                            ),
                          ),
                        ),
                      ),
                  )
                  : Center(
                    child: CircleAvatar(
                        minRadius: 80,
                        backgroundColor: Colors.transparent,
                        // backgroundImage: FileImage(_selectedImage!),
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(_selectedImage!),
                            ),
                          ),
                        ),
                      ),
                  ),
              const SizedBox(height: 20),
              _buildTextField(
                'Nome',
                _nomeController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Descrição',
                _descricaoController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Imagem',
                _imagemController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Nome URL',
                _nomeUrlController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Produtos',
                _produtosController,
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
                  onPressed: () async {
                    try {
                      if (_formKey.currentState!.validate()) {
                        CategoriaService categoriaService = CategoriaService();
                        await categoriaService.atualizarCategoria(
                          widget.categoria['id'],
                          _nomeController.text,
                          _descricaoController.text,
                          _selectedImage ?? File(widget.categoria['imagem']),
                          _nomeUrlController.text,
                          _produtosController.text,
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: Text(
                                'Atualização de Cateogria',
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
                                    'Voce atualizou a categoria ${widget.categoria['nome']} com sucesso!',
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
                      }
                    } catch (e) {
                      print("Erro ao atualizar categoria: $e");
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }
}
