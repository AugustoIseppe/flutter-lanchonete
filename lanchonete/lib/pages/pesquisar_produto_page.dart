import 'package:flutter/material.dart';

class PesquisarProdutoPage extends StatelessWidget {

  const PesquisarProdutoPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Pagina de Pesquisa'),),
           body: const Center(
             child: Text('Pesquisar Produto'),
           ),
       );
  }
}