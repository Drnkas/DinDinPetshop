import 'package:carousel_slider/carousel_slider.dart';
import 'package:dindin_petshop/models/product_manager.dart';
import 'package:dindin_petshop/pages/home/components/custom_carousel.dart';
import 'package:dindin_petshop/pages/home/components/custom_search.dart';
import 'package:dindin_petshop/pages/home/components/item_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dindin_petshop/config/app_images.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';
import '../../models/product.dart';
import '../../models/user_manager.dart';
import 'controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  final UserManager userManager = Get.find<UserManager>();
  final ProductManager productManager = Get.find<ProductManager>();

  List<Product> _getFilteredProductList() {
    final searchQuery = homeController.searchQuery.value.toLowerCase();
    return productManager.allProducts.value.where((product) {
      final productName = product.name!.toLowerCase();
      return productName.contains(searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body:  CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            toolbarHeight: 100,
            title: SizedBox(
              width: 500,
              height: 500,
              child: Image.asset(
                AppImages.logomini,
                fit: BoxFit.contain,
              ),
            ),
            floating: false,
            pinned: false,
            snap: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10
          ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                  Column(
                      children: [

                        //titulo
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Olá, ${userManager.user!.name!}!',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 25,
                                    color: AppColors.text,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        ),

                        //lojas
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Nossas lojas',
                                  style: GoogleFonts.fresca(
                                    textStyle: TextStyle(
                                        fontSize: 24,
                                        color: AppColors.text
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              Image.asset(
                                AppImages.patinha,
                                height: 60,
                                width: 220,
                              ),
                            ],
                          ),
                        ),

                        //Carousel
                        const CustomCarousel(),

                        //Novidades
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Novidades',
                                  style: GoogleFonts.fresca(
                                    textStyle: TextStyle(
                                        fontSize: 24,
                                        color: AppColors.text
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 35),
                              Image.asset(
                                AppImages.patinha,
                                height: 60,
                                width: 220,
                              ),
                            ],
                          ),
                        ),

                        //Pesquisar
                        const Padding(
                          padding:  EdgeInsets.symmetric(vertical: 10),
                          child:  CustomSearch(),
                        ),

                        //Produtos
                        Obx(
                              () => GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 9 / 11.5,
                              ),
                              itemCount: _getFilteredProductList().length,
                              itemBuilder: (_, index) {
                                final product = productManager.allProducts.value[index];

                                if (product.name!.contains(homeController.searchQuery.value)) {
                                  return ItemTile(product: product);
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

