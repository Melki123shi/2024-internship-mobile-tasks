import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:melkishitesfaye/features/product/data/model/product_model.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/get_product_usecase.dart';
import 'package:mockito/annotations.dart';

import '../../../../fixtures/fixture_reader.dart';

// import 'get_product_test.mocks.dart';

@GenerateMocks([GetProduct])
void main() {
  final tProduct = ProductModel(
      id: 'id',
      price: 10.0,
      category: 'productType',
      rating: 4.0,
      image : 'imageUrl',
      title: 'productName',
      description: 'description');

  test('should be class of Product', () async {
    expect(tProduct, isA<Product>());
  });

  group('fromJson', () {
    test(
      'should return a valid model when the id is string',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('product.json'));

        // act
        final result = ProductModel.fromJson(jsonMap);

        expect(result, tProduct);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tProduct.toJson();
        // assert
        final expectedJsonMap = {
          'id': 'id',
          'price': 10.0,
          'category': 'productType',
          'rating': {'rate': 4.0, 'count': 0},
          'image': 'imageUrl',
          'title': 'productName',
          'description': 'description'
        };

        expect(result, expectedJsonMap);
      },
    );
  });

}
