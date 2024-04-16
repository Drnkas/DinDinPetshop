import 'package:dindin_petshop/config/app_colors.dart';
import 'package:dindin_petshop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_images.dart';
import '../../models/cart_item_model.dart';
import '../../models/cart_manager.dart';
import '../../services/utils_services.dart';
import 'components/cart_tile.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final UtilsServices utilsServices = UtilsServices();
  final CartManager cartManager = Get.find<CartManager>();

  double cartTotalPrice() {
    double totalPrice = 0.0;
    for (var item in cartManager.items) {
      if (item.product.price != null && item.quantity != null) {
        totalPrice += item.product.price! * item.quantity!;
      }
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 100,
        title: SizedBox(
          width: 500,
          height: 500,
          child: Image.asset(
            AppImages.carrinho,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Column(
        children: [
          // Lista de itens do carrinho
          Expanded(
            child: ListView.builder(
              itemCount: cartManager.items.length,
              itemBuilder: (_, index) {
                return CartTile(
                  cartItem: cartManager.items[index],
                  remove: removeItemFromCart,
                );
              },
            ),
          ),

          // Total e botão de concluir o pedido
          Container(
            padding: const EdgeInsets.only(bottom: 130, top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total geral',
                        style: GoogleFonts.fresca(
                          textStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.text
                        ),
                      ),
                      ),
                      Text(
                        utilsServices.priceToCurrency(cartTotalPrice()),
                        style: TextStyle(
                          fontSize: 23,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () async {},
                      child: const Text(
                        'Concluir pedido',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  removeItemFromCart(CartItem item) {
  }
}
