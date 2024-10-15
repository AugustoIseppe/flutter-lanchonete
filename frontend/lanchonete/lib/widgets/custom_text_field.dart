import 'package:flutter/material.dart';
import 'package:lanchonete/services/product_service.dart';

class CustomTextField extends StatefulWidget {

  final TextEditingController searchProduct;
  CustomTextField({Key? key, required this.searchProduct}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    ProdutoService service = ProdutoService();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.searchProduct,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print(widget.searchProduct.text);
              service.pesquisarProduto(widget.searchProduct.text);
            },
          
          ),
          labelText: 'Pesquisar',
          labelStyle: TextStyle(color: Colors.grey),
          hintText: 'Digite sua pesquisa aqui',
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}
