import 'package:carousel_slider/carousel_slider.dart';
import 'package:dindin_petshop/pages/home/components/stores_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/stores_manager.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final StoresManager storeManager = Get.find<StoresManager>();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 260,
        enlargeCenterPage: true,
        autoPlay: false,
        aspectRatio: 2.0,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: storeManager.stores.map((store) {
        return StoreCard(store: store);
      }).toList(),
    );
  }
}
