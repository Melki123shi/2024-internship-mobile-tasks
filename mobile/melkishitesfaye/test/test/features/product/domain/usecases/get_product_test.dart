import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/get_product.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_product_test.mocks.dart';

// import 'get_product_test.mocks.dart';

@GenerateMocks([GetProduct])
void main() {
  group('getProduct', () {
    test('returns a product if the http call completes successfully', () async {
      final product = MockGetProduct();
      final tid = '1';
      final tProduct = Product(
        id: tid,
        price: 700,
        catagory: '',
        rating: 9,
        image: '',
        title: '',
        description: '',
      );

      when(product(Params(id: tid))).thenAnswer((_) async => Right(tProduct));
      final result = await product(Params(id: tid));

      expect(result, Right(tProduct));
    });
  
  });
}
