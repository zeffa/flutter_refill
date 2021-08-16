import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uji/core/network/network_info.dart';
import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  MockInternetConnectionChecker mockInternetConnectionChecker = MockInternetConnectionChecker();
  NetworkInfo networkInfo = NetworkInfoImpl(connectionChecker: mockInternetConnectionChecker);

  group("Internet Connection", () {
    test('check if connection checker was called', () async {
      final hasConnectionFuture = await Future.value(true);
      when(mockInternetConnectionChecker.hasConnection).thenAnswer((_) async => hasConnectionFuture);
      final isConnected = await networkInfo.isInternetAvailable;
      verify(mockInternetConnectionChecker.hasConnection);
      expect(isConnected, hasConnectionFuture);
      expect(isConnected, same(hasConnectionFuture));
    });
  });
}