import 'package:dindin_petshop/pages/cart/cart_page.dart';
import 'package:dindin_petshop/pages/home/home_page.dart';
import 'package:dindin_petshop/pages/orders/orders_page.dart';
import 'package:dindin_petshop/pages/profile/profile_page.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_images.dart';
import '../../models/user_manager.dart';
import 'controller/navigation_binding.dart';


class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final navigationController = Get.find<NavigationController>();
  final UserManager userManager = Get.find<UserManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationController.pageController,
        children: const [
          HomePage(),
          CartPage(),
          OrdersPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 140,
        child: DotNavigationBar(
          enablePaddingAnimation: false,
          backgroundColor: AppColors.primary,
          enableFloatingNavBar: true,
          currentIndex: navigationController.currentIndex,
          onTap: (index) {
            setState(() {
              navigationController.navigatePageView(index);
            });
        },
          dotIndicatorColor: Colors.transparent,
          items: [
            /// Home
            DotNavigationBarItem(
                icon: const Icon(Icons.home),
                selectedColor: Colors.brown,
                unselectedColor: Colors.grey[200]),

            /// Likes
            DotNavigationBarItem(
                icon: const Icon(Icons.shopping_cart_outlined),
                selectedColor: Colors.brown,
                unselectedColor: Colors.grey[200]),

            /// Search
            DotNavigationBarItem(
                icon: const Icon(Icons.format_list_bulleted_outlined),
                selectedColor: Colors.brown,
                unselectedColor: Colors.grey[200],
            ),

            /// Profile
            DotNavigationBarItem(
                icon: const Icon(Icons.person),
                selectedColor: Colors.brown,
                unselectedColor: Colors.grey[200]),
          ],
        ),
      ),
    );
  }
}
