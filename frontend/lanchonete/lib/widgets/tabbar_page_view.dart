import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lanchonete/utils/easy_colors.dart';
import 'package:lanchonete/widgets/category_list_view.dart';
import 'package:lanchonete/widgets/product_list_view.dart';

class TabbarPageView extends StatefulWidget {
  const TabbarPageView({super.key});

  @override
  State<TabbarPageView> createState() => _NestedPageViewState();
}

class _NestedPageViewState extends State<TabbarPageView> {
  @override
  Widget build(BuildContext context) {
    EasyColors easyColors = EasyColors();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: easyColors.secondaryColor,
        appBar: AppBar(
          backgroundColor: easyColors.primaryColor,
          foregroundColor: easyColors.secondaryColor,
          centerTitle: true,
          title: Text(
            'Menu',
            style: GoogleFonts.sevillana(
              color: easyColors.secondaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            labelStyle: TextStyle(
              color: easyColors.secondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            indicatorColor: easyColors.secondaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4,
            unselectedLabelColor: easyColors.secondaryColor,
            tabs: const [
              Tab(
                icon: Icon(
                  Icons.fastfood,
                  color: Color(0xfffff9e6),
                ),
                text: 'Produtos',
              ),
              Tab(
                icon: Icon(
                  Icons.category,
                  color: Color(0xfffff9e6),
                ),
                text: 'Categorias',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ProductListView(),
            CategoryListView(),
          ],
        ),
      ),
    );
  }
}
