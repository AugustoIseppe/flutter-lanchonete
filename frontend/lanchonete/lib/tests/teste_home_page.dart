import 'package:flutter/material.dart';
import 'package:lanchonete/tests/produtinho_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TesteHomePage extends StatefulWidget {
  const TesteHomePage({super.key});

  @override
  State<TesteHomePage> createState() => _TesteHomePageState();
}

class _TesteHomePageState extends State<TesteHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoriaService =
          Provider.of<ProdutinhoList>(context, listen: false);
      categoriaService.loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final produtosProvider = Provider.of<ProdutinhoList>(context);
    // produtosProvider.getDataFromApi();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider API CALL'),
        centerTitle: true,
      ),
      body: produtosProvider.produtos.isEmpty
          ? const Center(
              child: SpinKitFadingCircle(
                color: Colors.red,
                size: 50.0,
              ),
            )
          : ListView.builder(
              itemCount: produtosProvider.produtos.length,
              itemBuilder: (context, index) {
                print('AUISHDIUAHSDIUSH ${produtosProvider.produtos[index].nome}'); 
                print('produtosProvider.produtos.length : ${produtosProvider.produtos.length}');
                return ListTile(
                  title: Text(produtosProvider.produtos[index].nome),
                  subtitle: Text(produtosProvider.produtos[index].descricao),
                  // trailing:
                  //     Text(produtosProvider.produtos[index].valor.toString()),
                );
              },
            ),
    );
  }
}
