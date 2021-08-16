import 'package:uji/features/main/domain/usecases/check_login_status.dart';

class MainService {
  final CheckLoginStatus checkLoginStatus;

  MainService({required this.checkLoginStatus});

  Future<bool> isUserLoggedIn() async {
    return await checkLoginStatus.checkLoginStatus();
  }
}