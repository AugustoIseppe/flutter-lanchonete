import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lanchonete/database/auth.dart';
import 'package:lanchonete/pages/home_page.dart';
import 'package:lanchonete/pages/pagina_inicial_admin.dart';
import 'package:lanchonete/utils/easy_colors.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Obtendo o provedor de autenticação
      Auth auth = Provider.of<Auth>(context, listen: false);

      // Tentando fazer o login automático com as credenciais salvas
      final usuarioLogado = await auth.tryAutoLogin();

      if (usuarioLogado.isNotEmpty &&
          (usuarioLogado['nivel'] == 'admin' ||
              usuarioLogado['nivel'] == 'Admin')) {
        print('auth.usuarioLogado[nivel]: ${auth.usuarioLogado['nivel']}');
        auth.usuarioLogado = usuarioLogado;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PaginaInicialAdmin(usuarioLogado: usuarioLogado),
          ),
        );
      } else if (usuarioLogado.isNotEmpty) {
        auth.usuarioLogado = usuarioLogado;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(usuarioLogado: usuarioLogado),
          ),
        );
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  Future<void> _loginPage() async {
    Auth auth = Auth();
    try {
      if (_formKey.currentState!.validate()) {
        await auth.login(
          _usuarioController.text,
          _senhaController.text,
        );

        print('USUÁRIO LOGIN PAGE: ${auth.usuario}');
        print('SENHA LOGIN PAGE: ${auth.senha}');
        print('NÍVEL LOGIN PAGE: ${auth.nivel}');
        print('USUÁRIO LOGADO LOGIN PAGE: ${auth.usuarioLogado}');

        if (auth.usuario == _usuarioController.text &&
            auth.senha == _senhaController.text) {
          if (auth.nivel == 'admin' || auth.nivel == 'Admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PaginaInicialAdmin(usuarioLogado: auth.usuarioLogado),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomePage(usuarioLogado: auth.usuarioLogado),
              ),
            );
          }
        } else {
          _showErrorDialog(
              'Acesso negado. Tente novamente ou contate o administrador');
        }
      }
    } catch (e) {
      print('Erro ao fazer login: $e');
      _showErrorDialog(
          'Credenciais inválidas. Tente novamente ou contate o administrador');
    }
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        backgroundColor: Colors.grey[300],
        title: const Text(
          "Erro ao realizar login",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'NotoSans',
            fontSize: 14,
          ),
        ),
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'NotoSans',
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
            child: const Center(
              child: Text(
                "Fechar",
                style: TextStyle(
                  fontFamily: 'NotoSans',
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    EasyColors easyColors = EasyColors();
    return Scaffold(
      // backgroundColor: easyColors.secondaryColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: easyColors.primaryColor,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo da Lanchonete
                        Container(
                          margin: const EdgeInsets.only(bottom: 50),
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 80,
                                backgroundImage: AssetImage('assets/imagens/logo_snackbar.jpeg'),
                              ),
                              Text(
                                'Login Haven',
                                style: GoogleFonts
                                    .sofia(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        // Campo de Email
                        TextFormField(
                          controller: _usuarioController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email,
                                color: Color(0xfffff9e6)),
                            hintText: 'Usuário',
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        // Campo de Senha
                        TextFormField(
                          controller: _senhaController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock,
                                color: Color(0xfffff9e6)),
                            hintText: 'Senha',
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                        ),
                        const SizedBox(height: 40),
                        // Botão de Login
                        ElevatedButton(
                          onPressed: () {
                            // Lógica de login aqui
                            _loginPage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfffff9e6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 100.0, vertical: 15.0),
                            child: Text('Login'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Texto de cadastro
                        TextButton(
                          onPressed: () {
                            // Lógica para redirecionar para a tela de cadastro
                          },
                          child: const Text(
                            'Não tem uma conta? Cadastre-se',
                            style: TextStyle(color: Color(0xfffff9e6)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
