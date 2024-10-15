import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lanchonete/pages/editar_produto_page.dart';
import 'package:lanchonete/services/product_service.dart';
import 'package:lanchonete/utils/easy_colors.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class Produtos extends StatefulWidget {
  final Map<String, dynamic> usuarioLogado;
  const Produtos({super.key, required this.usuarioLogado});
  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final produtoService =
  //         Provider.of<ProdutoService>(context, listen: false);
  //     produtoService.listarProdutos();
  //   });
  // }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final produtoService = Provider.of<ProdutoService>(context);
    produtoService.listarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    EasyColors easyColors = EasyColors();
    final produtoService = Provider.of<ProdutoService>(context, listen: false);
    return Scaffold(
      backgroundColor: easyColors.secondaryColor,
      appBar: AppBar(
        title: Text('Produtos',
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: easyColors.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              produtoService.listarProdutos();
            },
            icon: const Icon(Iconsax.refresh, color: Colors.white),
          ),
        ],
      ),
      body: Consumer<ProdutoService>(
        builder: (context, service, child) {
          if (service.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitFadingCircle(
                    color: Colors.red,
                    size: 50.0,
                  ),
                  SizedBox(height: 20),
                  Text('Loading...'),
                ],
              ),
            );
          } else if (service.datumProdutos.data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.red[900],
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Nenhum produto cadastrado!',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else if (service.error.isNotEmpty) {
            return Center(child: Text(service.error));
          } else {
            return ListView.builder(
              itemCount: service.datumProdutos.data.length,
              itemBuilder: (context, index) {
                final produto = service.datumProdutos.data[index];
                return Card(
                  color: index.isOdd ? Colors.white : Colors.grey[200],
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              'http://10.0.2.2:8800/produtos/uploads/${produto.imagem}',
                            ),
                          ),
                          title: Text(
                            produto.nome,
                            style: GoogleFonts.actor(
                                fontSize: 18, fontWeight: FontWeight.w900),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              // Text(produto.descricao, style: GoogleFonts.poppins()),
                              const SizedBox(height: 5),
                              Text(
                                'R\$ ${produto.valor}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900],
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return EditarProdutoPage(
                                        produtos: produto.toMap(),
                                      );
                                    },
                                  ));
                                },
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        title: Text(
                                          'Excluir Produto',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const SizedBox(height: 10),
                                            Icon(Icons.delete,
                                                color: Colors.red[900],
                                                size: 48),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Deseja realmente excluir o produto ${produto.nome}?',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15),
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
                                              'Cancelar',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    153, 44, 75, 1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await service
                                                  .deletarProduto(produto.id);
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Row(
                                                    children: const [
                                                      Icon(Icons.check_circle,
                                                          color: Colors.white),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          'Produto excluído com sucesso!',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  backgroundColor:
                                                      Colors.green[900],
                                                  duration: const Duration(
                                                      seconds: 3),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  margin: const EdgeInsets.all(
                                                      10.0),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              'Sim',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    153, 44, 75, 1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: easyColors.primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, '/cadastrar_produto_page');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}