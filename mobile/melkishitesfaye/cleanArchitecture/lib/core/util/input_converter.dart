import 'package:dartz/dartz.dart';
import 'package:melkishitesfaye/core/error/faliure.dart';

class InputConverter {
  Either<Failure, double> stringToDouble(String str) {
    try {
      return Right(double.parse(str));
    } on FormatException {
      return Left(InvalidInputFaliure());
    }
  }
}

class InvalidInputFaliure extends Failure{}
