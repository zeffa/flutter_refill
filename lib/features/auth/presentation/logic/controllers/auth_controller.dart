import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uji/core/errors/failures.dart';
import 'package:uji/core/network/network_info.dart';
import 'package:uji/features/auth/data/datasource/local_data_source.dart';
import 'package:uji/features/auth/data/datasource/remote_data_source.dart';
import 'package:uji/features/auth/data/repositories/login_repository_impl.dart';
import 'package:uji/features/auth/domain/entities/login_response_entity.dart';
import 'package:uji/features/auth/domain/repositories/login_repository.dart';
import 'package:uji/features/auth/domain/usecases/login_user_service.dart';
import 'package:uji/features/auth/presentation/logic/services/auth_service.dart';
import 'package:uji/features/main/presentation/logic/main_controller.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormState = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  final homeController = Get.find<MainController>();

  var email = "".obs;
  var password = "".obs;
  var loginFailure = LoginFailure("").obs;
  var loginSuccess = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> initDependencies() async {
    final prefs = await SharedPreferences.getInstance();
    Get.lazyPut(() => http.Client());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut(() => InternetConnectionChecker());
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(
        connectionChecker: Get.find<InternetConnectionChecker>()));
    Get.lazyPut<RemoteDatasource>(
        () => RemoteDataSourceImpl(httpClient: Get.find<http.Client>()));
    Get.lazyPut<LocalDataSource>(
        () => LocalDataSourceImpl(sharedPreferences: prefs));
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl(
        remoteDatasource: Get.find<RemoteDatasource>(),
        localDataSource: Get.find<LocalDataSource>(),
        networkInfo: Get.find<NetworkInfo>()));
    Get.lazyPut(() => LoginUserService(Get.find<LoginRepository>()));
    Get.lazyPut(() => LoginService(Get.find<LoginUserService>()));
  }

  String? validateEmail(String email) {
    if (!GetUtils.isEmail(email)) {
      return "Invalid email address";
    }
    return null;
  }

  String? validatePhone(String email) {
    return null;
  }

  String? validatePassword(String password) {
    if (password.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  void bindFormInputValues() {
    if (!loginFormState.currentState!.validate()) {
      return;
    }
    loginFormState.currentState!.save();

    login();
  }

  void login() async {
    final service = Get.find<LoginService>();
    final result = await service.loginUser(email.value, password.value);
    result.fold(
      (failure) => _onLoginFailure(failure),
      (loginResponse) => _onLoginSuccess(loginResponse),
    );
  }

  void _onLoginFailure(Failure failure) {
    loginFailure.value = LoginFailure(failureMessage(failure));
    print(failureMessage(failure));
  }

  void _onLoginSuccess(LoginResponse loginResponse) {
    print(loginResponse);
    loginSuccess.value = true;
    homeController.isUserLoggedIn.value = true;
  }

  String failureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return "Saving data to local failed";
      case LoginFailure:
        return (failure as LoginFailure).message;
      default:
        return "Unknown Error";
    }
  }
}
