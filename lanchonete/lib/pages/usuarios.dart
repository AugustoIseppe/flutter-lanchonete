import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lanchonete/models/user_list.dart';
import 'package:lanchonete/utils/easy_colors.dart';
import 'package:provider/provider.dart';

class Usuarios extends StatefulWidget {
  final Map<String, dynamic> usuarioLogado;

  const Usuarios({Key? key, required this.usuarioLogado}) : super(key: key);

  @override
  State<Usuarios> createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
  EasyColors easyColors = EasyColors();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserList>(context, listen: false);
      userProvider.loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: easyColors.secondaryColor,
      appBar: AppBar(
        title: Text('Usuários',
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: easyColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Consumer<UserList>(
        builder: (context, UserList service, child) {
          if (service.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitFadingCircle(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                  SizedBox(height: 20),
                  Text('Loading...'),
                ],
              ),
            );
          } else if (service.users.isEmpty) {
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
              itemCount: context.watch<UserList>().users.length,
              itemBuilder: (context, index) {
                final user = context.watch<UserList>().users[index];
                return Card(
                  //* isOdd: se o index for ímpar, a cor do card será branca, senão, cinza
                  color: index.isOdd ? Colors.white : Colors.grey[200],
                  child: ExpansionTile(
                    leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              'http://10.0.2.2:8800/produtos/uploads/${user.imagem}',
                            ),
                          ),
                    // iconColor: easyColors.primaryColor,
                    trailing: Icon(Iconsax.arrow_circle_down, color: easyColors.primaryColor,),
                      title: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.nome,
                                style: GoogleFonts.abel(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                user.nivel,
                                style: GoogleFonts.robotoCondensed(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Nível: ${user.nivel}',
                                style: GoogleFonts.robotoCondensed(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('CPF: ${user.cpf}',
                                  style: GoogleFonts.robotoCondensed(
                                    fontWeight: FontWeight.w900,
                                  fontSize: 14
                                  )),
                            ],
                          ),
                        ),
                        ListTile(
                          minTileHeight: 0,
                          title: Text(
                            'Telefone: ${user.telefone}',
                            style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.w900,
                                fontSize: 14
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'E-mail: ${user.usuario}',
                            style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.w900,
                                  fontSize: 14
                            ),
                          ),
                        ),
                        //    Card(
                        //     color: Colors.white,
                        //   margin:
                        //       const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //   ),
                        //   elevation: 2,
                        //   child: Padding(
                        //     padding: EdgeInsets.all(10.0),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         ListTile(
                        //           contentPadding: EdgeInsets.zero,
                        //           leading: CircleAvatar(
                        //             radius: 40,
                        //             backgroundImage: NetworkImage(
                        //               'http://10.0.2.2:8800/produtos/uploads/${user.imagem}',
                        //             ),
                        //           ),
                        //           title: Text(
                        //             user.nome,
                        //             style: GoogleFonts.poppins(
                        //               fontSize: 18,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //           subtitle: Text(
                        //             user.nivel,
                        //             style: GoogleFonts.poppins(),
                        //           ),
                        //           trailing: Row(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               IconButton(
                        //                 onPressed: () {
                        //                   Navigator.push(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                       builder: (context) {
                        //                         return EditarUsuarioPage(
                        //                             usuario: user.toMap());
                        //                       },
                        //                     ),
                        //                   );
                        //                 },
                        //                 icon:
                        //                     const Icon(Icons.edit, color: Colors.blue),
                        //               ),
                        //               IconButton(
                        //                 onPressed: () {
                        //                   showDialog(
                        //                     context: context,
                        //                     builder: (BuildContext context) {
                        //                       return AlertDialog(
                        //                         shape: RoundedRectangleBorder(
                        //                           borderRadius:
                        //                               BorderRadius.circular(10.0),
                        //                         ),
                        //                         title: Text(
                        //                           'Excluir Usuário',
                        //                           style: GoogleFonts.poppins(
                        //                             fontSize: 20,
                        //                             fontWeight: FontWeight.bold,
                        //                           ),
                        //                           textAlign: TextAlign.center,
                        //                         ),
                        //                         content: Column(
                        //                           mainAxisSize: MainAxisSize.min,
                        //                           children: <Widget>[
                        //                             const SizedBox(height: 10),
                        //                             Icon(
                        //                               Icons.delete,
                        //                               color: Colors.red[900],
                        //                               size: 48,
                        //                             ),
                        //                             const SizedBox(height: 10),
                        //                             Text(
                        //                               'Deseja realmente excluir o usuário ${user.nome}?',
                        //                               style: GoogleFonts.poppins(
                        //                                 fontSize: 15,
                        //                               ),
                        //                               textAlign: TextAlign.center,
                        //                             ),
                        //                           ],
                        //                         ),
                        //                         actions: <Widget>[
                        //                           TextButton(
                        //                             onPressed: () async {
                        //                               Navigator.of(context).pop();
                        //                             },
                        //                             child: const Text(
                        //                               'Cancelar',
                        //                               style: TextStyle(
                        //                                 color: Color.fromRGBO(
                        //                                     153, 44, 75, 1),
                        //                                 fontSize: 16,
                        //                                 fontWeight: FontWeight.bold,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                           TextButton(
                        //                             onPressed: () async {
                        //                               UsuarioService usuarioService =
                        //                                   UsuarioService();
                        //                               await usuarioService
                        //                                   .deletarUsuario(user.id);
                        //                               Navigator.of(context).pop();
                        //                               ScaffoldMessenger.of(context)
                        //                                   .showSnackBar(
                        //                                 SnackBar(
                        //                                   content: const Row(
                        //                                     children: [
                        //                                       Icon(
                        //                                         Icons.check_circle,
                        //                                         color: Colors.white,
                        //                                       ),
                        //                                       SizedBox(width: 10),
                        //                                       Expanded(
                        //                                         child: Text(
                        //                                           'Usuário excluído com sucesso!',
                        //                                           style: TextStyle(
                        //                                             color: Colors.white,
                        //                                             fontSize: 16,
                        //                                             fontWeight:
                        //                                                 FontWeight.bold,
                        //                                           ),
                        //                                         ),
                        //                                       ),
                        //                                     ],
                        //                                   ),
                        //                                   backgroundColor:
                        //                                       Colors.green[900],
                        //                                   duration: const Duration(
                        //                                       seconds: 3),
                        //                                   behavior:
                        //                                       SnackBarBehavior.floating,
                        //                                   shape: RoundedRectangleBorder(
                        //                                     borderRadius:
                        //                                         BorderRadius.circular(
                        //                                             10.0),
                        //                                   ),
                        //                                   margin: const EdgeInsets.all(
                        //                                       10.0),
                        //                                 ),
                        //                               );
                        //                               setState(() {});
                        //                             },
                        //                             child: const Text(
                        //                               'Sim',
                        //                               style: TextStyle(
                        //                                 color: Color.fromRGBO(
                        //                                     153, 44, 75, 1),
                        //                                 fontSize: 16,
                        //                                 fontWeight: FontWeight.bold,
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ],
                        //                       );
                        //                     },
                        //                   );
                        //                 },
                        //                 icon:
                        //                     const Icon(Icons.delete, color: Colors.red),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ]),
                );
              },
            );

            // body: SingleChildScrollView(
            // child: FutureBuilder(
            //   future: usuarioService.listarUsuarios(),
            //   builder:
            //       (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text('Erro: ${snapshot.error}'));
            //     } else {
            //       print(snapshot.data);
            //       return SingleChildScrollView(
            //         child: Container(
            //           color: easyColors.secondaryColor,
            //           height: MediaQuery.of(context).size.height - 167,
            //           child: snapshot.data!.isEmpty
            //               ? Container(
            //                   color: Colors.grey[200],
            //                   child: Center(
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         Icon(
            //                           Icons.warning,
            //                           color: Colors.red[900],
            //                           size: 50,
            //                         ),
            //                         const SizedBox(height: 10),
            //                         Text(
            //                           'Nenhum usuário cadastrado!',
            //                           style: GoogleFonts.poppins(
            //                             fontSize: 18,
            //                             fontWeight: FontWeight.bold,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 )
            //               : ListView.builder(
            //                   itemCount: snapshot.data!.length,
            //                   shrinkWrap: true,
            //                   itemBuilder: (context, index) {
            //                     return Card(
            //                                                       color: Colors.white,
            //                       margin: const EdgeInsets.symmetric(
            //                           horizontal: 10, vertical: 2),
            //                       shape: RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(10.0),
            //                       ),
            //                       elevation: 2,
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(10.0),
            //                         child: Column(
            //                           crossAxisAlignment: CrossAxisAlignment.center,
            //                           children: [
            //                             ListTile(
            //                               contentPadding: EdgeInsets.zero,
            //                               leading: CircleAvatar(
            //                                 radius: 40,
            //                                 backgroundImage: NetworkImage(
            //                                   'http://10.0.2.2:8800/produtos/uploads/${snapshot.data![index]['imagem']}',
            //                                 ),
            //                               ),
            //                               title: Text(
            //                                 snapshot.data![index]['nome'],
            //                                 style: GoogleFonts.poppins(
            //                                   fontSize: 18,
            //                                   fontWeight: FontWeight.bold,
            //                                 ),
            //                               ),
            //                               subtitle: Text(
            //                                 snapshot.data![index]['nivel'],
            //                                 style: GoogleFonts.poppins(),
            //                               ),
            //                               trailing: Row(
            //                                 mainAxisSize: MainAxisSize.min,
            //                                 children: [
            //                                   IconButton(
            //                                     onPressed: () {
            //                                       Navigator.push(
            //                                         context,
            //                                         MaterialPageRoute(
            //                                           builder: (context) {
            //                                             return EditarUsuarioPage(
            //                                                 usuario: snapshot
            //                                                     .data![index]);
            //                                           },
            //                                         ),
            //                                       );
            //                                     },
            //                                     icon: const Icon(Icons.edit,
            //                                         color: Colors.blue),
            //                                   ),
            //                                   IconButton(
            //                                     onPressed: () {
            //                                       showDialog(
            //                                         context: context,
            //                                         builder:
            //                                             (BuildContext context) {
            //                                           return AlertDialog(
            //                                             shape:
            //                                                 RoundedRectangleBorder(
            //                                               borderRadius:
            //                                                   BorderRadius.circular(
            //                                                       10.0),
            //                                             ),
            //                                             title: Text(
            //                                               'Excluir Usuário',
            //                                               style:
            //                                                   GoogleFonts.poppins(
            //                                                 fontSize: 20,
            //                                                 fontWeight:
            //                                                     FontWeight.bold,
            //                                               ),
            //                                               textAlign:
            //                                                   TextAlign.center,
            //                                             ),
            //                                             content: Column(
            //                                               mainAxisSize:
            //                                                   MainAxisSize.min,
            //                                               children: <Widget>[
            //                                                 const SizedBox(
            //                                                     height: 10),
            //                                                 Icon(
            //                                                   Icons.delete,
            //                                                   color:
            //                                                       Colors.red[900],
            //                                                   size: 48,
            //                                                 ),
            //                                                 const SizedBox(
            //                                                     height: 10),
            //                                                 Text(
            //                                                   'Deseja realmente excluir o usuário ${snapshot.data![index]['nome']}?',
            //                                                   style: GoogleFonts
            //                                                       .poppins(
            //                                                     fontSize: 15,
            //                                                   ),
            //                                                   textAlign:
            //                                                       TextAlign.center,
            //                                                 ),
            //                                               ],
            //                                             ),
            //                                             actions: <Widget>[
            //                                               TextButton(
            //                                                 onPressed: () async {
            //                                                   Navigator.of(context)
            //                                                       .pop();
            //                                                 },
            //                                                 child: const Text(
            //                                                   'Cancelar',
            //                                                   style: TextStyle(
            //                                                     color:
            //                                                         Color.fromRGBO(
            //                                                             153,
            //                                                             44,
            //                                                             75,
            //                                                             1),
            //                                                     fontSize: 16,
            //                                                     fontWeight:
            //                                                         FontWeight.bold,
            //                                                   ),
            //                                                 ),
            //                                               ),
            //                                               TextButton(
            //                                                 onPressed: () async {
            //                                                   UsuarioService
            //                                                       usuarioService =
            //                                                       UsuarioService();
            //                                                   await usuarioService
            //                                                       .deletarUsuario(
            //                                                           snapshot.data![
            //                                                                   index]
            //                                                               ['id']);
            //                                                   Navigator.of(context)
            //                                                       .pop();
            //                                                   ScaffoldMessenger.of(
            //                                                           context)
            //                                                       .showSnackBar(
            //                                                     SnackBar(
            //                                                       content:
            //                                                           const Row(
            //                                                         children: [
            //                                                           Icon(
            //                                                             Icons
            //                                                                 .check_circle,
            //                                                             color: Colors
            //                                                                 .white,
            //                                                           ),
            //                                                           SizedBox(
            //                                                               width:
            //                                                                   10),
            //                                                           Expanded(
            //                                                             child: Text(
            //                                                               'Usuário excluído com sucesso!',
            //                                                               style:
            //                                                                   TextStyle(
            //                                                                 color: Colors
            //                                                                     .white,
            //                                                                 fontSize:
            //                                                                     16,
            //                                                                 fontWeight:
            //                                                                     FontWeight.bold,
            //                                                               ),
            //                                                             ),
            //                                                           ),
            //                                                         ],
            //                                                       ),
            //                                                       backgroundColor:
            //                                                           Colors.green[
            //                                                               900],
            //                                                       duration:
            //                                                           const Duration(
            //                                                               seconds:
            //                                                                   3),
            //                                                       behavior:
            //                                                           SnackBarBehavior
            //                                                               .floating,
            //                                                       shape:
            //                                                           RoundedRectangleBorder(
            //                                                         borderRadius:
            //                                                             BorderRadius
            //                                                                 .circular(
            //                                                                     10.0),
            //                                                       ),
            //                                                       margin:
            //                                                           const EdgeInsets
            //                                                               .all(
            //                                                               10.0),
            //                                                     ),
            //                                                   );
            //                                                   setState(() {});
            //                                                 },
            //                                                 child: const Text(
            //                                                   'Sim',
            //                                                   style: TextStyle(
            //                                                     color:
            //                                                         Color.fromRGBO(
            //                                                             153,
            //                                                             44,
            //                                                             75,
            //                                                             1),
            //                                                     fontSize: 16,
            //                                                     fontWeight:
            //                                                         FontWeight.bold,
            //                                                   ),
            //                                                 ),
            //                                               ),
            //                                             ],
            //                                           );
            //                                         },
            //                                       );
            //                                     },
            //                                     icon: const Icon(Icons.delete,
            //                                         color: Colors.red),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     );
            //                   },
            //
            //
            //  ),
          }
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: easyColors.primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, '/cadastrar_usuario_page');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
