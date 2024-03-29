import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remove_produt_test.mocks.dart';



@GenerateMocks([DeleteProductUseCase])
void main() {
  group('removeProduct', () {
    test('returns a sucess message if the http call completes successfully', () async {
      final product = MockDeleteProductUseCase();
      final tid = '1';
      final String successProduct = 'Product deleted';

      when(product(DeleteParams(id: tid))).thenAnswer((_) async => Right(successProduct));
      final result = await product(DeleteParams(id: tid));

      expect(result, Right(successProduct));
    });

    test('throws error if the http call does not complete successfully', () async {
      final product = MockDeleteProduct();
      final tid = '1';
      final String successProduct = 'Product deleted';

      // when(product(DeleteParams(id: tid))).thenAnswer((_) async => Right(successProduct));
      // final result = await product(DeleteParams(id: tid));

      // expect(result, Right(successProduct));
    });
  });
}

class MockDeleteProduct {
}
