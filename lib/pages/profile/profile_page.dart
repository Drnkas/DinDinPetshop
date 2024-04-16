import 'package:dindin_petshop/pages_routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';
import '../../config/app_images.dart';
import '../../models/user_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserManager userManager = Get.find<UserManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Center(
          child: SizedBox(
            height: 700,
            width: 500,
            child: Stack(
                children:[

                  //Card
                  Positioned(
                    top: 166,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 500,
                      child: Card(
                        clipBehavior: Clip.none,
                        surfaceTintColor: Colors.white,
                        elevation: 5,
                        shadowColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              //Titulo
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Dados Pessoais',
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
                                      width: 150,
                                    ),
                                  ],
                                ),
                              ),

                              //Nome
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: userManager.user!.name!,
                                  decoration: InputDecoration(
                                    prefix: Row(
                                      children: [
                                        Icon(Icons.person, color: AppColors.primary),
                                        const SizedBox(width: 5),
                                        Text(
                                          'Nome:',
                                          style: GoogleFonts.fresca(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(userManager.user!.name!),
                                      ],
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    // label: Text("Nome")
                                  ),
                                ),
                              ),

                              Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 1,
                              ),

                              //Email
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: userManager.user!.email!,
                                  decoration: InputDecoration(
                                    prefix: Row(
                                      children: [
                                        Icon(Icons.email_outlined, color: AppColors.primary),
                                        const SizedBox(width: 5),
                                        Text(
                                          'Email:',
                                          style: GoogleFonts.fresca(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(userManager.user!.email!),
                                      ],
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    // label: Text("Email")
                                  ),
                                ),
                              ),
                              //SizedBox(height: 20),

                              Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 1,
                              ),
                              //Sair
                              TextButton.icon(
                                onPressed: () {
                                  userManager.signOut();
                                  Get.toNamed(PagesRoutes.signInRoute);
                                },
                                style: TextButton.styleFrom(
                                    side: BorderSide.none
                                ),
                                icon: Icon(Icons.exit_to_app, color: AppColors.primary,),
                                label: Text(
                                  'Sair',
                                  style: GoogleFonts.fresca(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Imagem
                  Positioned(
                    top: -173,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      AppImages.people,
                      height: 600,
                      width: 350,
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
