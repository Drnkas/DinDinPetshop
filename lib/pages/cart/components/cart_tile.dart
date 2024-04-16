import 'package:dindin_petshop/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/cart_item_model.dart';
import '../../../models/cart_manager.dart';
import '../../../services/utils_services.dart';
import '../../commom_widgets/quantity_widget.dart';

class CartTile extends StatefulWidget {
  final CartItem cartItem;
  final Function(CartItem) remove;

  const CartTile({
    Key? key,
    required this.cartItem,
    required this.remove,
  }) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilsServices utilsServices = UtilsServices();
  final CartManager cartManager = Get.find<CartManager>();

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(

        // Imagem
        leading: SizedBox(
          width: 60,
          height: 60,
          child: Image.network(
            widget.cartItem.product.images!.first,
            fit: BoxFit.cover,
          ),
        ),

        // Titulo
        title: Text(
          widget.cartItem.product.name!,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),

        // Total
        subtitle: Text(
          'R\$ ${widget.cartItem.unitPrice.toStringAsFixed(2)}',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Quantidade
        trailing: QuantityWidget(
          value: widget.cartItem.quantity!.toDouble().round(),
          result: (quantity) {
            setState(() {
              widget.cartItem.quantity = quantity as double?;

              if (quantity == 0) {
                // Remover item do carrinho
                widget.remove(widget.cartItem);
              }
            });
          },
          isRemovable: true,
        ),
      ),
    );
  }
}