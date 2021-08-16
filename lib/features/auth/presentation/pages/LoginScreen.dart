import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uji/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:uji/features/auth/presentation/widgets/text_fields.dart';
import 'package:uji/features/home/presentation/logic/home_binding.dart';
import 'package:uji/features/home/presentation/pages/LandingScreen.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: controller.loginFormState,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Image.asset(
                  "images/refill_icon.png",
                  height: 150,
                  width: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                loginPhoneInput(controller),
                SizedBox(
                  height: 16,
                ),
                loginPasswordInput(controller),
                SizedBox(
                  height: 16,
                ),
                loginButton(
                    controller: controller,
                    onLoginPressed: () {
                      controller.bindFormInputValues();
                    }),
              ],
            ),
          ),
        ),
        padding: EdgeInsets.all(32),
      ),
    );
  }
}
