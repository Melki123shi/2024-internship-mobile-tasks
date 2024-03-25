import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:melkishitesfaye/core/network/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'netwrok_info_test.mocks.dart';


@GenerateMocks([Connectivity])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  group('isConnected', () {
    test(
      'should forward the call to Connectivity.checkConnectivity',
      () async {
        // arrange
        final tConnectivityResult = ConnectivityResult.wifi;

        when(mockConnectivity.checkConnectivity())
            .thenAnswer((_) => Future.value(tConnectivityResult));
        // act
        final result = await networkInfo.isConnected;
        // assert
        verify(mockConnectivity.checkConnectivity());
        expect(result, equals(true)); 
      },
    );
  });
}
