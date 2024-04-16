import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_images.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
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
            AppImages.pedidos,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
