// import 'package:flutter/material.dart';
// import 'package:lanchonete/services/categoria_service.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CardCategoria extends StatefulWidget {
//   const CardCategoria({
//     super.key,
//     required this.service,
//   });

//   final CategoriaService service;

//   @override
//   State<CardCategoria> createState() => _CardCategoriaState();
// }

// class _CardCategoriaState extends State<CardCategoria> {

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     widget.service.listarCategorias();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final 
//     return FutureBuilder(
//         future: widget.service.listarCategorias(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Erro ao listar usuários: ${snapshot.error}');
//           } else {
//             final data = snapshot.data!;
//             return SizedBox(
//               height: 140,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     width: 200,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Stack(
//                           children: [
//                             Card(
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 child: Image.network(
//                                   'https://cdn.pixabay.com/photo/2017/08/22/00/29/burger-2667443_1280.jpg',
//                                   fit: BoxFit.cover,
//                                   width: 200,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               left: 0,
//                               right: 0,
//                               top: 80,
//                               child: Container(
//                                 width: 200,
//                                 color: Colors.white.withOpacity(0.4),
//                                 child: ListTile(
//                                   title: Text(
//                                     data[index]['nome'],
//                                     style: GoogleFonts.acme(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w900
//                                     ),
//                                     textAlign: TextAlign.start,
//                                   ),
//                                   subtitle: Padding(
//                                     padding: const EdgeInsets.only(bottom: 10.0, top: 0),
//                                     child: Text(
//                                       data[index]['descricao'],
//                                       style: GoogleFonts.acme(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black
//                                     ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 itemCount: data.length,
//               ),
//             );
//           }
//         });
//   }
// }
