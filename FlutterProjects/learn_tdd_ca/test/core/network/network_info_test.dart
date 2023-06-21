import 'package:flutter_test/flutter_test.dart';
import 'package:learn_tdd_ca/core/network/network_info.dart';
import 'package:mocktail/mocktail.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MockDataConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
        'should check InternetConnectionChecker.hasConnection() when it returns true',
        () async {
          when(() => mockDataConnectionChecker.hasConnection).thenAnswer((_) async => true);

          final result = await networkInfo.isConnected;

          verify(() => mockDataConnectionChecker.hasConnection);
          expect(result, true);
        }
    );

    test(
        'should check InternetConnectionChecker.hasConnection() when it returns false',
            () async {
          when(() => mockDataConnectionChecker.hasConnection).thenAnswer((_) async => false);

          final result = await networkInfo.isConnected;

          verify(() => mockDataConnectionChecker.hasConnection);
          expect(result, false);
        }
    );
  });
}