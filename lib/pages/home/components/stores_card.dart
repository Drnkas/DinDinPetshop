import 'package:dindin_petshop/config/app_colors.dart';
import 'package:dindin_petshop/models/stores_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/store.dart';

class StoreCard extends StatelessWidget {
  final Store store;
  StoreCard({super.key, required this.store});

  final StoresManager stores = Get.find<StoresManager>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Card(
        elevation: 3,
        surfaceTintColor: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //imagem
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)
                ),
                child: Container(
                  height: 250,
                  width: 100,
                  child: Image.network(
                    store.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Nome
                      Text(
                        store.name!,
                        style: GoogleFonts.fresca(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: AppColors.primary
                          ),
                        ),
                      ),

                      //Endereço
                      Text(
                        store.address!,
                        style: GoogleFonts.fresca(
                          textStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.text
                          ),
                        ),
                      ),

                      //Horario
                      Text(
                        store.getOpeningText(),
                        style: GoogleFonts.fresca(
                          textStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.text
                          ),
                        ),
                      ),

                      Text(
                        store.phone!,
                        style: GoogleFonts.fresca(
                          textStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.text
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
