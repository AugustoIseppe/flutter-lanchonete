import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lanchonete/services/categoria_service.dart';
import 'package:lanchonete/utils/easy_colors.dart';
import 'package:provider/provider.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoriaService>(context);
    EasyColors easyColors = EasyColors();
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.error.isNotEmpty) {
      return Center(child: Text(provider.error));
    }
    return ListView.builder(
      itemCount: context.watch<CategoriaService>().categoryList.data.length,
      itemBuilder: (context, index) {
        final category =
            context.watch<CategoriaService>().categoryList.data[index];
        return Card(
          elevation: 1, // Remove a sombra
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Define o raio da borda
            side: BorderSide.none, // Remove qualquer borda
          ),
          //* isOdd: se o index for ímpar, a cor do card será branca, senão, cinza
          color: index.isOdd ? Colors.white : Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
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
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  'http://10.0.2.2:8800/produtos/uploads/${category.imagem}',
                ),
              ),
              // iconColor: easyColors.primaryColor,
              trailing: Icon(
                Iconsax.arrow_circle_down,
                color: easyColors.primaryColor,
              ),
              title: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      category.nome,
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: easyColors.primaryColor,
                      ),
                    ),
                      
                    ],
                  ),
                ],
              ),
              children: [
                ListTile(
                  title: Text(
                    'Descrição: ${category.descricao}',
                    style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
