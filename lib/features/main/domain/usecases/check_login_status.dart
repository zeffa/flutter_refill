import 'package:uji/core/usecases/use_case_login_status.dart';
import 'package:uji/features/main/domain/repositories/main_repository.dart';

class CheckLoginStatus implements CheckLoginStatusUseCase {
  final MainRepository mainRepository;

  CheckLoginStatus({required this.mainRepository});

  @override
  Future<bool> checkLoginStatus() async {
    return await mainRepository.checkIfLogged();
  }
}
