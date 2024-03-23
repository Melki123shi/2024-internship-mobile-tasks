import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:melkishitesfaye/core/util/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToDouble', () {
    test(
      'should return an double when the string represents an integer',
      () async {
        // arrange
        final str = '123';
        // act
        final result = inputConverter.stringToDouble(str);
        // assert
        expect(result, Right(123.0));
      },
    );

    test(
      'should return an double when the string represents a double',
      () async {
        // arrange
        final str = '123.0';
        // act
        final result = inputConverter.stringToDouble(str);
        // assert
        expect(result, Right(123.0));
      },
    );

    test(
  'should return a failure when the string is not an integer nor a double',
  () async {
    // arrange
    final str = 'abc';
    // act
    final result = inputConverter.stringToDouble(str);
    // assert
    expect(result, Left(InvalidInputFaliure()));
  },
);
  });
}
