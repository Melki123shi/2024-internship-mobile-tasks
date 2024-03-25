import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:melkishitesfaye/core/usecase/usecase.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/get_products.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_products_test.mocks.dart';

@GenerateMocks([GetProducts])
void main() {
  group('getProducts', () {
    test('returns a product if the http call completes successfully', () async {
      final products = MockGetProducts();
      final product = Product(id: '', price: 12, catagory: '', rating: 3, image: '', title: '', description: '');
      final List<Product> tProducts = [product];

      when(products.call(NoParams())).thenAnswer((_) async => Right(tProducts));
      final result = await products.call(NoParams());

      expect(result, Right(tProducts));
    });
  });
}
