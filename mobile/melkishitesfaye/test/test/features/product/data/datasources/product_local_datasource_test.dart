import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:melkishitesfaye/core/error/exception.dart';
import 'package:melkishitesfaye/features/product/data/datasources/product_local_datasource.dart';
import 'package:melkishitesfaye/features/product/data/model/product_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'product_local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastProductList', () {
    final List<String> cachedProducts = fixtureList('product_cached.json');
    final List<ProductModel> tProducts = cachedProducts
        .map((product) => ProductModel.fromJson(json.decode(product)))
        .toList();
    test(
      'should return Product list from SharedPreferences when there is atleast one in the cache',
      () async {
        when(mockSharedPreferences.getStringList(any))
            .thenReturn(fixtureList('product_cached.json'));

        final result = await dataSource.getAvailableProducts();
        verify(mockSharedPreferences.getStringList(CACHED_PRODUCTS));
        expect(result, tProducts);
      },
    );
    test(
      'should throw chache exception  when there is no product cached in SharedPreferences',
      () {
        when(mockSharedPreferences.getStringList(any)).thenReturn(null);

        final call = dataSource.getAvailableProducts;
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheProducts', () {
    test('should call SharedPreferences to cache the data', () async {
      final ProductModel productModel = ProductModel(
        id: "123",
        price: 10.0,
        catagory: "catagory",
        rating: 4.0,
        image: "image",
        title: "title",
        description: "description",
      );
      
      final List<ProductModel> tProducts = [productModel];
      final expectedJsonStrings =
          tProducts.map((product) => json.encode(product.toJson())).toList();

      when(mockSharedPreferences.setStringList(
        any,
        any,
      )).thenAnswer((_) => Future.value(true));

      // act
      await dataSource.cacheProducts(tProducts);

      //assert
      verify(mockSharedPreferences.setStringList(
        CACHED_PRODUCTS,
        expectedJsonStrings,
      )).called(1);
    });
  });

}
