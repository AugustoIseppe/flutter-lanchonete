// import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lanchonete/database/auth.dart';
import 'package:lanchonete/pages/login_page.dart';
import 'package:lanchonete/services/categoria_service.dart';
import 'package:lanchonete/services/product_service.dart';
import 'package:lanchonete/utils/easy_colors.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> usuarioLogado;
  const HomePage({
    super.key,
    required this.usuarioLogado,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchProductController = TextEditingController();
  EasyColors easyColors = EasyColors();
  int activeIndex = 0;
  ValueNotifier<int> activeIndexNotifier = ValueNotifier<int>(0);
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoriaService =
          Provider.of<CategoriaService>(context, listen: false);
      categoriaService.listarCategorias();
      final produtoService =
          Provider.of<ProdutoService>(context, listen: false);
      produtoService.listarProdutos();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.usuarioLogado['nivel']);
    return Scaffold(
      backgroundColor: easyColors.secondaryColor,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                    image: AssetImage('assets/imagens/logo_snackbar1.jpeg'),
                    fit: BoxFit.cover),
              ),
              child: Text(
                'Bem-vindo, ${widget.usuarioLogado['nome']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Login'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
            if (widget.usuarioLogado['nivel'] == 'admin' ||
                widget.usuarioLogado['nivel'] == 'Admin')
              ListTile(
                title: const Text('Administrador'),
                onTap: () {
                  Navigator.pushNamed(context, '/usuarios');
                },
              ),
            ListTile(
              title: const Text('Sair'),
              onTap: () {
                Auth auth = Provider.of<Auth>(context, listen: false);
                auth.logout();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Página Inicial',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: easyColors.primaryColor,
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () async {
              // service.listarCategorias();
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          //! Header
          Flexible(
            flex: 0,
            fit: FlexFit.tight,
            child: Container(
              height: 60,
              // color: Colors.brown,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Olá, ${widget.usuarioLogado['nome'] ?? 'Usuário'}',
                          style: GoogleFonts.actor(
                            color: easyColors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          'O que você deseja hoje?',
                          style: GoogleFonts.actor(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/nested_page_view');
                      },
                      child: Chip(
                        side: BorderSide.none,
                        backgroundColor: easyColors.primaryColor,
                        label: Row(
                          children: [
                            Text(
                              'Menu',
                              style: GoogleFonts.actor(
                                color: easyColors.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                textStyle: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xfffff9e6),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(Iconsax.menu_board,
                                color: easyColors.secondaryColor),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //! Categorias
          Flexible(
            flex: 0,
            fit: FlexFit.tight,
            child: Container(
              height: 115,
              // color: Colors.blue,
              child: Consumer<CategoriaService>(
                builder: (context, service, child) {
                  if (service.isLoading) {
                    return const Center(
                      child: SpinKitFadingCircle(
                        color: Color(0xff6f1610),
                        size: 50.0,
                      ),
                    );
                  }

                  if (service.error.isNotEmpty) {
                    return Center(
                      child: Text(
                        'Erro ao carregar categorias: ${service.error}',
                        style: GoogleFonts.roboto(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  final dataLength = service.categoryList.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 111,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(4),
                          itemCount: dataLength.length,
                          itemBuilder: (context, i) {
                            final category = service.categoryList.data[i];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width *
                                              .5),
                                      child: Image.network(
                                        'http://10.0.2.2:8800/categorias/uploads/${category.imagem}',
                                        width: 100,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  category.nome,
                                  style: GoogleFonts.actor(
                                    textStyle: const TextStyle(
                                        color: Color(0xff6f1610),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          //! Categorias => Carousel
          Flexible(
            flex: 0,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Especialidades',
                      style: GoogleFonts.actor(
                        color: easyColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Consumer<CategoriaService>(
                      builder: (context, service, child) {
                        if (service.isLoading) {
                          return const Center(
                            child: SpinKitFadingCircle(
                              color: Color(0xff6f1610),
                              size: 50.0,
                            ),
                          );
                        }

                        if (service.error.isNotEmpty) {
                          return Center(
                            child: Text(
                              'Erro ao carregar categorias: ${service.error}',
                              style: GoogleFonts.roboto(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                        final dataLength = service.categoryList.data;
                        return Column(
                          children: [
                            Container(
                              // color: Colors.cyan,
                              height: 235,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  // height: 160,]

                                  viewportFraction: 1,
                                  autoPlay: true,
                                  disableCenter: true,
                                  scrollDirection: Axis.horizontal,
                                  enlargeCenterPage: false,
                                  pageSnapping: false,
                                  enableInfiniteScroll: true,
                                  padEnds: false,
                                  onPageChanged: (index, reason) {
                                    activeIndexNotifier.value = index;
                                  },
                                ),
                                items: dataLength.map((category) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'http://10.0.2.2:8800/categorias/uploads/${category.imagem}',
                                      // width: 250,
                                      fit: BoxFit.cover,
                                      // alignment: Alignment.center,
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                height: 100,
                // color: Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Produtos em Destaque',
                      style: GoogleFonts.actor(
                        color: easyColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Consumer<ProdutoService>(
                      builder: (context, service, child) {
                        if (service.isLoading) {
                          return const Center(
                            child: SpinKitFadingCircle(
                              color: Color(0xff6f1610),
                              size: 50.0,
                            ),
                          );
                        }

                        if (service.error.isNotEmpty) {
                          return Center(
                            child: Text(
                              'Erro ao carregar categorias: ${service.error}',
                              style: GoogleFonts.roboto(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 190,
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: 4,
                                itemBuilder: (context, i) {
                                  final products =
                                      service.datumProdutos.data[i];
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Image.network(
                                        'http://10.0.2.2:8800/categorias/uploads/${products.imagem}',
                                        // width: 50,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        backgroundColor: easyColors.primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Ionicons.log_out_outline),
      ),
      bottomNavigationBar: widget.usuarioLogado['nivel'] == 'Cliente'
          ? BottomAppBar(
              height: 70,
              padding: const EdgeInsets.all(0),
              color: easyColors.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Iconsax.home, size: 25),
                            onPressed: () {
                              // Navigator.pushNamed(context, '/login');
                            },
                            color: Colors.white,
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                      const Positioned(
                        bottom: 0,
                        child: Text(
                          'Home',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon:
                                const Icon(Iconsax.search_normal_14, size: 25),
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            color: Colors.white,
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                      const Positioned(
                        bottom: 0,
                        child: Text(
                          'Busca',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Iconsax.setting, size: 25),
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            color: Colors.white,
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                      const Positioned(
                        bottom: 0,
                        child: Text(
                          'Perfil',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
