import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uji/features/main/data/datasource/main_local_data_source.dart';
import 'package:uji/features/main/data/repositories/main_repository_impl.dart';
import 'package:uji/features/main/domain/repositories/main_repository.dart';
import 'package:uji/features/main/domain/usecases/check_login_status.dart';
import 'package:uji/features/main/presentation/logic/main_service.dart';

class MainController extends GetxController {
  var isUserLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> initDependencies() async {
    final prefs = await SharedPreferences.getInstance();
    Get.put<MainLocalDataSource>(MainLocalDataSourceImpl(prefs),
        permanent: true);
    Get.put<MainRepository>(
        MainRepositoryImpl(localDataSource: Get.find<MainLocalDataSource>()),
        permanent: true);
    Get.put(CheckLoginStatus(mainRepository: Get.find<MainRepository>()),
        permanent: true);
    Get.put(MainService(checkLoginStatus: Get.find<CheckLoginStatus>()));

    checkIfUserLoggedIn();
  }

  void checkIfUserLoggedIn() async {
    final mainService = Get.find<MainService>();
    isUserLoggedIn.value = await mainService.isUserLoggedIn();
  }
}
