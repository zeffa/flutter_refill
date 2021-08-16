import 'package:uji/features/main/data/datasource/main_local_data_source.dart';
import 'package:uji/features/main/domain/repositories/main_repository.dart';

class MainRepositoryImpl implements MainRepository {
  final MainLocalDataSource localDataSource;

  MainRepositoryImpl({required this.localDataSource});

  @override
  Future<bool> checkIfLogged() async {
    return await localDataSource.getUserLoginStatus();
  }
}
