import 'package:dindin_petshop/config/app_colors.dart';
import 'package:dindin_petshop/models/user.dart';
import 'package:dindin_petshop/pages/base/base_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';

import '../../config/app_images.dart';
import '../../helpers/firebase_errors.dart';
import '../../models/user_manager.dart';
import '../../pages_routes/app_routes.dart';
import '../commom_widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = signal('');
  final pass = signal('');
  final passError = signal<String?>(null);
  final emailError = signal<String?>(null);

  late final isValid = computed(() => email().isNotEmpty && pass().isNotEmpty);

  final UserManager userManager = Get.find<UserManager>();

  bool validateForm() {
    bool isValid = true;

    if (pass().length < 6) {
      passError.value = 'Senha inválida';
      isValid = false;
    } else {
      passError.value = null;
    }

    final RegExp regex = RegExp(r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");

    if (regex.hasMatch(email())) {
      emailError.value = null;
    } else {
      emailError.value = 'E-mail inválido';
      isValid = false;
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundLogin,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Nome do app
                      Image.asset(
                        AppImages.logo2,
                        fit: BoxFit.contain,
                        width: 350,
                        height: 350,
                      ),

                      // Formulário
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 40,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(45),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'Login',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.fresca(
                                      textStyle: TextStyle(
                                          fontSize: 30,
                                          color: AppColors.primary
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Obx(() {
                                return CustomTextField(
                                  enabled: !userManager.loading.value,
                                  icon: Icons.email,
                                  label: 'Email',
                                  onChanged: email.set,
                                  textError: emailError.value,
                                );
                              }),


                              // Senha
                              Obx(() {
                                return CustomTextField(
                                  enabled: !userManager.loading.value,
                                  textError: passError.value,
                                  icon: Icons.lock,
                                  label: 'Senha',
                                  isSecret: true,
                                  onChanged: pass.set,
                                );
                              }),

                              // Botão de entrar
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: () {
                                   isValid.watch(context) ? validateForm : null;
                                    if(validateForm()){
                                      final user = UserApp(
                                          email: email(),
                                          password: pass());

                                      userManager.signIn(user).then((_) {

                                        Get.toNamed(PagesRoutes.baseRoute);

                                      }).catchError((error) {
                                        String errorMessage = getErrorString(error.code);
                                        Get.snackbar(
                                          'Erro de autenticação',
                                          errorMessage,
                                          backgroundColor: Colors.red,
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      });
                                    }
                                  },
                                  child: Obx(() {
                                    return userManager.loading.value
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                        'Entrar',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white
                                        )
                                    );
                                  }
                                  ),
                                ),
                              ),

                              // Esqueceu a senha
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Esqueceu a senha?',
                                    style: TextStyle(
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                ),
                              ),

                              // Divisor
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey.withAlpha(90),
                                        thickness: 2,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: Text('Ou'),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey.withAlpha(90),
                                        thickness: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Botão de novo usuário
                              SizedBox(
                                height: 50,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    side: BorderSide(
                                      width: 2,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.toNamed(PagesRoutes.signUpRoute);
                                  },
                                  child: Text(
                                    'Criar conta',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.primary
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
