import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lanchonete/pages/categorias.dart';
import 'package:lanchonete/pages/home_page.dart';
import 'package:lanchonete/pages/produtos.dart';
import 'package:lanchonete/pages/usuarios.dart';
import 'package:lanchonete/utils/easy_colors.dart';

class PaginaInicialAdmin extends StatefulWidget {
  final Map<String, dynamic> usuarioLogado;

  const PaginaInicialAdmin({super.key, required this.usuarioLogado});

  @override
  State<PaginaInicialAdmin> createState() => _PaginaInicialAdminState();
}

class _PaginaInicialAdminState extends State<PaginaInicialAdmin> {
  late List<Widget> _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomePage(usuarioLogado: widget.usuarioLogado),
      Usuarios(usuarioLogado: widget.usuarioLogado),
      Produtos(usuarioLogado: widget.usuarioLogado),
      Categorias(usuarioLogado: widget.usuarioLogado),
      // Adicione outras páginas aqui
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    EasyColors easyColors = EasyColors();
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: easyColors.primaryColor,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        selectedLabelStyle:
            GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
        elevation: 0,
        iconSize: 27,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home_hashtag),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'Usuários',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.shopping_bag),
            label: 'Produtos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.category),
            label: 'Categorias',
          ),
        ],
      ),
    );
  }
}
