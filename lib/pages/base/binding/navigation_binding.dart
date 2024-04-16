import 'package:get/get.dart';

import '../controller/navigation_binding.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}