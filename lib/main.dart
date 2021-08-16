import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uji/core/utils/colors.dart';
import 'package:uji/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:uji/features/auth/presentation/pages/LoginScreen.dart';
import 'package:uji/features/main/presentation/logic/main_binding.dart';
import 'package:uji/features/main/presentation/logic/main_controller.dart';

import 'features/home/presentation/pages/LandingScreen.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final mainController = Get.put(MainController());
    await mainController.initDependencies();
    Get.put(LoginController()).initDependencies();
    runApp(MyApp());
  }, (e, s) => print(e));
}

class MyApp extends StatelessWidget {
  final controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MainBinding(),
      title: 'Refill Station',
      theme: ThemeData(
        primaryColor: RefillStationColors.background(),
      ),
      home: Obx(() {
        if (controller.isUserLoggedIn.value == false) {
          return LoginScreen();
        }
        return LandingScreen();
      }),
      debugShowCheckedModeBanner: false,
    );
  }
}
