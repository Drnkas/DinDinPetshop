import 'package:dindin_petshop/pages/Auth/login_page.dart';
import 'package:dindin_petshop/pages/auth/sign_up.dart';
import 'package:dindin_petshop/pages/base/base_screen.dart';
import 'package:dindin_petshop/pages/base/binding/navigation_binding.dart';
import 'package:dindin_petshop/pages/product/product_page.dart';
import 'package:dindin_petshop/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../pages/cart/cart_page.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      page: () => ProductPage(),
      name: PagesRoutes.productRoute,
    ),
    GetPage(
      page: () => CartPage(),
      name: PagesRoutes.cartRoute,
    ),
    GetPage(
      page: () => const SplashPage(),
      name: PagesRoutes.splashRoute,
    ),
    GetPage(
      page: () => LoginPage(),
      name: PagesRoutes.signInRoute,
    ),
    GetPage(
      page: () => SignUpPage(),
      name: PagesRoutes.signUpRoute,
    ),
    GetPage(
      page: () => const BaseScreen(),
      name: PagesRoutes.baseRoute,
      bindings: [
        NavigationBinding(),
      ],
    ),
  ];
}

abstract class PagesRoutes {
  static const String productRoute = '/product';
  static const String cartRoute = '/cart';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/';
}