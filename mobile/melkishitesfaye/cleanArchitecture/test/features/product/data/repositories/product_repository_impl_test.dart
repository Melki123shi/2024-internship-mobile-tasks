import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:melkishitesfaye/core/error/exception.dart';
import 'package:melkishitesfaye/core/error/faliure.dart';
import 'package:melkishitesfaye/core/network/network_info.dart';
import 'package:melkishitesfaye/features/product/data/datasources/product_local_data_source.dart';
import 'package:melkishitesfaye/features/product/data/datasources/product_remote_data_source.dart';
import 'package:melkishitesfaye/features/product/data/model/product_model.dart';
import 'package:melkishitesfaye/features/product/data/repositories/product_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_repository_impl_test.mocks.dart';

@GenerateMocks([ProductRemoteDataSource])
@GenerateMocks([ProductLocalDataSource])
@GenerateMocks([NetworkInfo])
void main() {
  final mockRemoteDataSource = MockProductRemoteDataSource();
  final mockProductLocalDataSource = MockProductLocalDataSource();
  final mockNetworkInfo = MockNetworkInfo();

  final repository = ProductRepositoryImpl(
    remoteDataSource: mockRemoteDataSource,
    localDataSource: mockProductLocalDataSource,
    networkInfo: mockNetworkInfo,
  );

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getProduct', () {
    final tid = '1';
    final tProductModel = ProductModel(
      id: 'id',
      price: 12.0,
      category: 'productType',
      rating: 3.0,
      image: 'image',
      title: 'productName',
      description: 'description',
    );
    final tProduct = tProductModel;

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getProduct(any))
              .thenAnswer((_) async => tProductModel);
          // act
          final result = await repository.getProduct(tid);
          // assert
          verify(mockRemoteDataSource.getProduct(tid));
          expect(result, equals(Right(tProduct)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getProduct(tid))
              .thenAnswer((_) async => tProductModel);
          // act
          await repository.getProduct(tid);
          // assert
          verify(mockRemoteDataSource.getProduct(tid));
        },
      );

      test(
        'should not interact with local data source when remote call fails',
        () async {
          // arrange
          when(mockRemoteDataSource.getProduct(any))
              .thenThrow(ServerException());
          // act
          await repository.getProduct('2');
          // assert
          verify(mockRemoteDataSource.getProduct('2'));
        },
      );
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getProduct(tid))
              .thenThrow(ServerException());
          // act
          final result = await repository.getProduct(tid);
          // assert
          verify(mockRemoteDataSource.getProduct(tid));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });

  group('getProducts', () {
    final tProductModel = ProductModel(
       id: 'id',
      price: 12,
      category: 'productType',
      rating: 3,
      image: 'image',
      title: 'productName',
      description: 'description',
    );

    runTestsOnline(() {
      // test(
      //   'should return remote data when the call to remote data source is successful',
      //   () async {
      //     // arrange
      //     final List<ProductModel> remoteProducts = [
      //       tProductModel
      //     ]; // Sample remote products
      //     when(mockRemoteDataSource.getProducts())
      //         .thenAnswer((_) async => remoteProducts);
      //     // act
      //     final result = await repository.getProducts();
      //     // assert
      //     verify(mockRemoteDataSource.getProducts());
      //     expect(result, equals(Right(remoteProducts)));
      //   },
      // );

      // test(
      //   'should cache the data locally when the call to remote data source is successful',
      //   () async {
      //     // arrange
      //     final List<ProductModel> remoteProducts = [tProductModel]; // Sample remote products
      //     when(mockRemoteDataSource.getProducts())
      //         .thenAnswer((_) async => remoteProducts);
      //     // act
      //     await repository.getProducts();
      //     // assert
      //     verify(mockRemoteDataSource.getProducts());
      //     verify(mockProductLocalDataSource.getAvalableProducts());
      //   },
      // );

      //   test(
      //     'should return server failure when the call to remote data source is unsuccessful',
      //     () async {
      //       // arrange
      //       when(mockRemoteDataSource.getProducts())
      //           .thenThrow(ServerException());
      //       // act
      //       final result = await repository.getProducts();
      //       // assert
      //       verify(mockRemoteDataSource.getProducts());
      //       expect(result, equals(Left(ServerFailure())));
      //     },
      //   );
      // });

      // runTestsOffline(() {
      //   test(
      //     'should return last locally cached data when the cached data is present',
      //     () async {
      //       // arrange
      //       final List<ProductModel> cachedProducts = [tProductModel]; // Sample cached products
      //       when(mockProductLocalDataSource.getAvailableProducts())
      //           .thenAnswer((_) async => cachedProducts);
      //       // act
      //       final result = await repository.getProducts();
      //       // assert
      //       verify(mockProductLocalDataSource.getAvailableProducts());
      //       expect(result, equals(Right(cachedProducts)));
      //     },
      //   );

      // test(
      //   'should return CacheFailure when there is no cached data present',
      //   () async {
      //     // arrange
      //     when(mockProductLocalDataSource.getAvailableProducts())
      //         .thenThrow(CacheException());
      //     // act
      //     final result = await repository.getProducts();
      //     // assert
      //     verify(mockProductLocalDataSource.getAvailableProducts());
      //     expect(result, equals(Left(CacheFailure())));
      //   },
      // );
    });
  });
}
