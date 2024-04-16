import 'package:dindin_petshop/models/product_manager.dart';
import 'package:dindin_petshop/pages_routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../config/app_colors.dart';
import '../../../models/product.dart';
import '../../../services/utils_services.dart';

class ItemTile extends StatelessWidget {
  final Product product;
  ItemTile({required this.product, super.key});

  final ProductManager productManager = Get.find<ProductManager>();
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(PagesRoutes.productRoute, arguments: product);
      },
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 5,
        shadowColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //imagem
              Expanded(child: Image.network(product.images!.first)),

              //Titulo
              Text(
                  product.name!,
                style: GoogleFonts.fresca(
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: AppColors.text,
                    fontWeight: FontWeight.w800
                  ),
                ),
              ),

              //Preço
              Text(
                  utilsServices.priceToCurrency(product.price!),
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
