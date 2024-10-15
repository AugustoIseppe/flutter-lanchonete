import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lanchonete/services/product_service.dart';
import 'package:lanchonete/utils/easy_colors.dart';
import 'package:provider/provider.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    EasyColors easyColors = EasyColors();
    final provider = Provider.of<ProdutoService>(context);
    if (provider.isLoading) {
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
    }
    if (provider.error.isNotEmpty) {
      return Center(child: Text(provider.error));
    }
    return ListView.builder(
      itemCount: context.watch<ProdutoService>().datumProdutos.data.length,
      itemBuilder: (context, index) {
        final produto =
            context.watch<ProdutoService>().datumProdutos.data[index];
            log(produto.descricao_longa.toString());
        return Card(
          elevation: 1, // Remove a sombra
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Define o raio da borda
            side: BorderSide.none, // Remove qualquer borda
          ),
          //* isOdd: se o index for ímpar, a cor do card será branca, senão, cinza
          color: index.isOdd ? Colors.white : Colors.grey[200],
          child: ExpansionTile(
            collapsedIconColor: easyColors.primaryColor,
            // tilePadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            childrenPadding: EdgeInsets.zero, // Remove o padding dos filhos
            visualDensity: VisualDensity.compact,
            shape: ShapeBorder.lerp(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide.none,
              ),
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide.none,
              ),
              0,
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                  'http://10.0.2.2:8800/produtos/uploads/${produto.imagem}'),
            ),
            // iconColor: easyColors.primaryColor,
            title: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto.nome,
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: easyColors.primaryColor,
                      ),
                    ),
                    Text(
                      'R\$ ${produto.valor.toString()}',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.green[900],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            children: [
              ListTile(
                leading: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.network(
                        'http://10.0.2.2:8800/produtos/uploads/${produto.imagem}', ),),
                ),
                title: Text(
                  produto.descricao_longa,
                  style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    color: easyColors.primaryColor,
                    
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
