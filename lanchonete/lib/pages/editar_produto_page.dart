import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lanchonete/services/product_service.dart';
import 'package:lanchonete/utils/easy_colors.dart';
import 'package:provider/provider.dart';

class EditarProdutoPage extends StatefulWidget {
  final Map<String, dynamic> produtos;
  const EditarProdutoPage({
    super.key,
    required this.produtos,
  });

  @override
  State<EditarProdutoPage> createState() => _EditarProdutoPageState();
}

class _EditarProdutoPageState extends State<EditarProdutoPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nomeController;
  late TextEditingController _descricaoController;
  late TextEditingController _descricaoLongaController;
  late TextEditingController _valorController;
  late TextEditingController _categoriaController;
  late TextEditingController _imagemController;
  late TextEditingController _nomeUrlController;
  late TextEditingController _comboController;
  late TextEditingController _vendasController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.produtos['nome']);
    _descricaoController =
        TextEditingController(text: widget.produtos['descricao']);
    _descricaoLongaController =
        TextEditingController(text: widget.produtos['descricao_longa']);
    _valorController =
        TextEditingController(text: widget.produtos['valor'].toString());
    _categoriaController =
        TextEditingController(text: widget.produtos['categoria'].toString());
    _imagemController = TextEditingController(text: widget.produtos['imagem']);
    _nomeUrlController =
        TextEditingController(text: widget.produtos['nome_url']);
    _comboController =
        TextEditingController(text: widget.produtos['combo'].toString());
    _vendasController =
        TextEditingController(text: widget.produtos['vendas'].toString());
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _descricaoLongaController.dispose();
    _valorController.dispose();
    _categoriaController.dispose();
    _imagemController.dispose();
    _nomeUrlController.dispose();
    _comboController.dispose();
    _vendasController.dispose();
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
    ProdutoService service = ProdutoService();

    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ProdutoService service, child) {
            return Text(
              'Produto: ${widget.produtos['nome']}',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: easyColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: easyColors.secondaryColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _selectedImage == null
                    ? CircleAvatar(
                        minRadius: 100,
                        backgroundImage: NetworkImage(
                            'http://10.0.2.2:8800/produtos/uploads/${widget.produtos['imagem']}'),
                        child: const Text(''))
                    : CircleAvatar(
                        minRadius: 100,
                        backgroundImage: FileImage(_selectedImage!),
                        child: const Text(''),
                      ),
                const SizedBox(height: 20),
                const SizedBox(height: 10),
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
                  'Descrição Longa',
                  _descricaoLongaController,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  'Valor',
                  _valorController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  'Categoria',
                  _categoriaController,
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
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  'Combo',
                  _comboController,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  'Vendas',
                  _vendasController,
                  keyboardType: TextInputType.number,
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
                          // Implementar a lógica de atualização aqui
                          await service.atualizarProduto(
                            widget.produtos['id'],
                            _nomeController.text,
                            _descricaoController.text,
                            _descricaoLongaController.text,
                            _valorController.text,
                            _categoriaController.text,
                            _selectedImage ?? File(widget.produtos['imagem']),
                            _nomeUrlController.text,
                            _comboController.text,
                            _vendasController.text,
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                title: Text(
                                  'Atualização de Produto',
                                  style: GoogleFonts.poppins(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
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
                                      'Produto atualizado com sucesso!',
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
                        print('Erro ao atualizar produto: $e');
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
