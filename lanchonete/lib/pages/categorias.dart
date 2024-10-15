import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lanchonete/pages/editar_categoria_page.dart';
import 'package:lanchonete/services/categoria_service.dart';
import 'package:lanchonete/utils/easy_colors.dart';
import 'package:provider/provider.dart';

class Categorias extends StatefulWidget {
  final Map<String, dynamic> usuarioLogado;

  const Categorias({Key? key, required this.usuarioLogado}) : super(key: key);

  @override
  State<Categorias> createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final categoriaService = Provider.of<CategoriaService>(context);
    categoriaService.listarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    EasyColors easyColors = EasyColors();

    return Scaffold(
      backgroundColor: easyColors.secondaryColor,
        appBar: AppBar(
          title: Text('Categorias',
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: easyColors.primaryColor,
          foregroundColor: Colors.white,
        ),
        body: Consumer(
          builder: (context, CategoriaService categoriaService, child) {
            if (categoriaService.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (categoriaService.error.isNotEmpty) {
              return Text(
                  'Erro ao listar categorias: ${categoriaService.error}');
            } else {
              return ListView.builder(
                itemCount: categoriaService.categoryList.data.length,
                itemBuilder: (context, index) {
                  final categoria = categoriaService.categoryList.data[index];
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
                              backgroundColor: Colors.transparent,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      'http://10.0.2.2:8800/categorias/uploads/${categoria.imagem}',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              categoria.nome,
                              style: GoogleFonts.actor(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                            subtitle: Text(
                              'Quantidade: ${categoria.produtos}',
                              style: GoogleFonts.actor(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return EditarCategoriaPage(
                                          categoria: categoria.toMap(),
                                        );
                                      },
                                    ));
                                  },
                                  icon:
                                      Icon(Icons.edit, color: Colors.blue[900]),
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
                                            'Excluir categoria',
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
                                                'Deseja realmente excluir o categoria ${categoria.nome}?',
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
                                                await categoriaService
                                                    .deletarCategoria(
                                                        categoria.id);
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Row(
                                                      children: const [
                                                        Icon(Icons.check_circle,
                                                            color:
                                                                Colors.white),
                                                        SizedBox(width: 10),
                                                        Expanded(
                                                          child: Text(
                                                            'categoria excluído com sucesso!',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    backgroundColor:
                                                        Colors.green[900],
                                                    duration: const Duration(
                                                        seconds: 3),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    margin:
                                                        const EdgeInsets.all(
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
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
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
            Navigator.pushNamed(context, '/cadastrar_categoria_page');
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
