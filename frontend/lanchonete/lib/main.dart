import 'package:flutter/material.dart';
import 'package:lanchonete/database/auth.dart';
import 'package:lanchonete/models/user_list.dart';
import 'package:lanchonete/pages/cadastrar_categoria.dart';
import 'package:lanchonete/pages/cadastrar_produto.dart';
import 'package:lanchonete/pages/editar_categoria_page.dart';
import 'package:lanchonete/pages/editar_produto_page.dart';
import 'package:lanchonete/pages/editar_usuario_page.dart';
import 'package:lanchonete/pages/login_page.dart';
import 'package:lanchonete/pages/cadastrar_usuario.dart';
import 'package:lanchonete/routes/app_routes.dart';
import 'package:lanchonete/services/categoria_service.dart';
import 'package:lanchonete/services/product_service.dart';
import 'package:lanchonete/widgets/tabbar_page_view.dart';
import 'package:provider/provider.dart';
import 'package:lanchonete/pages/pesquisar_produto_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => ProdutoService()),
        ChangeNotifierProvider(create: (context) => CategoriaService()),
        ChangeNotifierProvider(create: (context) => UserList()),
      ],
      child: MaterialApp(
        // home: NestedScrollViewExampleApp(),
        home: LoginScreen(),
        theme: ThemeData(
          primaryColor: Color(0xff6f1610),
          fontFamily: 'Lato',
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          // AppRoutes.usuariosPage: (context) => UsuariosPage(),
          AppRoutes.loginPage: (context) => LoginScreen(),
          AppRoutes.editarProdutoPage: (context) => const EditarProdutoPage( produtos: {}),
          AppRoutes.editarUsuarioPage: (context) => const EditarUsuarioPage(usuario: {}),
          AppRoutes.editarCategoriaPage: (context) => const EditarCategoriaPage(categoria: {}),
          AppRoutes.pesquisarProdutoPage: (context) => const PesquisarProdutoPage(),
          AppRoutes.cadastrarProdutoPage: (context) => CadastrarProduto(),
          AppRoutes.cadastrarUsuarioPage: (context) => CadastrarUsuario(),
          AppRoutes.cadastrarCategoriaPage: (context) => CadastrarCategoria(),
          AppRoutes.nestedPageView: (context) => const TabbarPageView(),
        }
      ),
    );
  }
}


