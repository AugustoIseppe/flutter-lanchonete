// import 'package:flutter/material.dart';
// import 'package:lanchonete/services/produto_service.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CardProdutos extends StatelessWidget {
//   const CardProdutos({
//     super.key,
//     required this.produtoService,
//   });

//   final ProdutoService produtoService;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: produtoService.listarProdutos(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Erro ao listar usuários: ${snapshot.error}');
//           } else {
//             final data = snapshot.data!;
//             return SizedBox(
//               height: MediaQuery.of(context).size.height * 0.6,
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 1,

//                 ),
//                 itemBuilder: (context, index) {
//                   return SizedBox(
//                     height: 300,
//                     child: Stack(
//                       children: [
//                         Card(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(8.0),
//                             child: Image.network(
//                               'https://cdn.pixabay.com/photo/2017/08/22/00/29/burger-2667443_1280.jpg',
//                               fit: BoxFit.cover,
//                               width: 200,
//                               height: 300,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           left: 0,
//                           right: 0,
//                           top: 150,
//                           child: Container(
//                             width: 200,
//                             color: Colors.white.withOpacity(0.4),
//                             child: ListTile(
//                               title: Text(
//                                 data[index]['nome'],
//                                 style: GoogleFonts.acme(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w900
//                                 ),
//                                 textAlign: TextAlign.start,
//                               ),
//                               subtitle: Padding(
//                                 padding: const EdgeInsets.only(bottom: 10.0, top: 0),
//                                 child: Text(
//                                   data[index]['descricao'],
//                                   style: GoogleFonts.acme(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black
//                                 ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 itemCount: 4,
//               ),
//             );
//           }
//         });
//   }
// }
