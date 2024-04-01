import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:melkishitesfaye/core/error/exception.dart';
import 'package:melkishitesfaye/features/product/data/datasources/product_remote_data_source.dart';
import 'package:melkishitesfaye/features/product/data/model/product_model.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'product_remote_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;
  final String baseUri = 'https://products-api-5a5n.onrender.com/api/v1/products';

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpCliesntSucess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('product.json'), 200),
    );
  }

  void setUpMockHttpCliesntFialure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('product.json'), 404),
    );
  }

  group('getProduct', () {
    final tid = '123';
    final tProduct =
        ProductModel.fromJson(json.decode(fixture('product.json')));

    test(
      '''should preform a GET request on a URL with id being 
      the endpoint and with application/json header''',
      () async {
        //arrange
        setUpMockHttpCliesntSucess200();
        // act
        dataSource.getProduct(tid);
        // assert
        verify(mockHttpClient.get(
          Uri.parse('$baseUri/$tid'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return Product when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpCliesntSucess200();
        // act
        final result = await dataSource.getProduct(tid);
        // assert
        expect(result, equals(tProduct));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpCliesntFialure404();
        // act
        final call = dataSource.getProduct;
        // assert
        expect(() => call(tid), throwsA(TypeMatcher<ServerException>()));
      },
    );
  
  });

  group('deleteProducts', () {
    final String tid = '1';
    // test(
    //   'should preform a GET request on a URL products endpoint and with application/json header',
    //   () async {
    //     //arrange
    //     when(mockHttpClient.delete(any, headers: anyNamed('headers')))
    //         .thenAnswer(
    //       (_) async => http.Response(fixture('product.json'), 200),
    //     );
    //     // act
    //     dataSource.deleteProduct(tid);
    //     // assert
    //     verify(mockHttpClient.delete(
    //       Uri.parse('$baseUri/$tid'),
    //       headers: {'Content-Type': 'application/json'},
    //     )).called(1);
    //   },
    // );

    // test(
    //   '''should return '{"message": "Product deleted"}' 
    //   when the response code is 200 (success)''',
    //   () async {
    //     // arrange
    //      when(mockHttpClient.delete(any, headers: anyNamed('headers')))
    //         .thenAnswer(
    //       (_) async => http.Response('{"message": "Product deleted"}', 200),
    //     );
    //     // act
    //     final result = await dataSource.deleteProduct(tid);
    //     // assert
    //     expect(result, '{"message": "Product deleted"}');
    //   },
    // );

    // test(
    //   'should throw a ServerException when the response code is 404 or other',
    //   () async {
    //     // arrange
    //     setUpMockHttpCliesntFialure404();
    //     // act
    //     final call = dataSource.getProduct;
    //     // assert
    //     expect(() => call(tid), throwsA(TypeMatcher<ServerException>()));
    //   },
    // );
  });

  void setUpMockHttpCliesntGetProductsSucess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('products.json'), 200),
    );
  }

  void setUpMockHttpCliesntGetProductsFialure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('products.json'), 404),
    );
  }

  group('getProducts', () {
    final tProducts = File('test/fixtures/products.json').readAsStringSync();
    final List<dynamic> jsonList = json.decode(tProducts);
    final List<ProductModel> products =
        jsonList.map((json) => ProductModel.fromJson(json)).toList();
    // test(
    //   'should preform a GET request on a URL products endpoint and with application/json header',
    //   () {
    //     //arrange
    //     setUpMockHttpCliesntGetProductsSucess200();
    //     // act
    //     dataSource.getProducts();
    //     // assert
    //     verify(mockHttpClient.get(
    //       Uri.parse(
    //           '$baseUri'),
    //       headers: {'Content-Type': 'application/json'},
    //     ));
    //   },
    // );

    // test(
    //   'should return list of Products when the response code is 200 (success)',
    //   () async {
    //     // arrange
    //     setUpMockHttpCliesntGetProductsSucess200();
    //     // act
    //     final result = await dataSource.getProducts();
    //     // assert
    //     expect(result, equals(products));
    //   },
    // );

    // test(
    //   'should throw a ServerException when the response code is 404 or other',
    //   () async {
    //     // arrange
    //     setUpMockHttpCliesntGetProductsFialure404();
    //     // act
    //     final call = dataSource.getProducts;
    //     // assert
    //     expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    //   },
    // );
  });

  // group('deleteProducts', () {
  //   final String tid = '1';
  //   test(
  //     'should preform a GET request on a URL products endpoint and with application/json header',
  //     () {
  //       //arrange
  //       when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
  //         (_) async => http.Response(fixture('trivia.json'), 200),
  //       );
  //       // act
  //       dataSource.deleteProduct(tid);
  //       // assert
  //       verify(mockHttpClient.delete(
  //         ('https://products-api-5a5n.onrender.com/apiapi/v1/' + tid) as Uri,
  //         headers: {'Content-Type': 'application/json'},
  //       ));
  //     },
  //   );
  // });
}
