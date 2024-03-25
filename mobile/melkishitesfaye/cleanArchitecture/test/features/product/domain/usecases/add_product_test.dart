import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/add_product.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_product_test.mocks.dart';

@GenerateMocks([AddProduct])
void main() {
  group('addProduct', () {
    test('returns the added product if the http call completes successfully', () async {
      final product = MockAddProduct();
      final tProduct = Product(
        id: '1',
        price: 700,
        catagory: '',
        rating: 9,
        image: '',
        title: '',
        description: '',
      );

      when(product(Params(product: tProduct)))
          .thenAnswer((_) async => Right(tProduct));

      final result = await product(Params(product: tProduct));

      expect(result, Right(tProduct));
    });
  });

}
