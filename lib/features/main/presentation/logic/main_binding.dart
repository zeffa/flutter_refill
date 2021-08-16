import 'package:get/get.dart';
import 'package:uji/features/auth/presentation/logic/login_binding.dart';
import 'package:uji/features/home/presentation/logic/home_binding.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginBinding());
    Get.lazyPut(() => HomeBinding());
  }
}
