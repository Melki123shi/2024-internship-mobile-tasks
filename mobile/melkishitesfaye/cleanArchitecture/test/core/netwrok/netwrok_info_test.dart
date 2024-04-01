import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:melkishitesfaye/core/network/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'netwrok_info_test.mocks.dart';


@GenerateMocks([InternetConnection])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnection mockInternetConnection;

  setUp(() {
    mockInternetConnection = MockInternetConnection();
    networkInfo = NetworkInfoImpl(mockInternetConnection);
  });

  group('isConnected', () {
    test(
      'should forward the call to InternetConnectionChecker.hasConnection',
      () async {
        // arrange
        final tHasConnection = Future.value(true); // or false based on your test case

        when(mockInternetConnection.hasInternetAccess)
            .thenAnswer((_) => tHasConnection);
        // act
        final result = await networkInfo.isConnected;
        // assert
        verify(mockInternetConnection.hasInternetAccess);
        expect(result, equals(true)); // or false based on your test case
      },
    );
  });
}
