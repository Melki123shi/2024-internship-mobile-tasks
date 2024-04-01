import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/update_product_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_product_test.mocks.dart';


@GenerateMocks([UpdateProductUseCase])
void main() {
  group('getProduct', () {
    test('returns a product if the http call completes successfully', () async {
      final product = MockUpdateProductUseCase();
      final tid = '1';
      final tProduct = Product(
        id: '1',
        price: 700,
        category: '',
        rating: 9,
        image: '',
        title: '',
        description: '',
      );
      
      when(product(UpdateParams(product: tProduct, id: tid)))
          .thenAnswer((_) async => Right(tProduct));

      final result = await product(UpdateParams(product: tProduct, id: tid));

      expect(result, Right(tProduct));
      // expect(updateProduct, Right(result));
    });
  });
}
