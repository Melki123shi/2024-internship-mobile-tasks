// Mocks generated by Mockito 5.4.4 from annotations
// in melkishitesfaye/test/features/product/data/repositories/product_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:melkishitesfaye/core/network/network_info.dart' as _i7;
import 'package:melkishitesfaye/features/product/data/datasources/product_local_datasource.dart'
    as _i6;
import 'package:melkishitesfaye/features/product/data/datasources/product_remote.dart'
    as _i3;
import 'package:melkishitesfaye/features/product/domain/entities/product.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeProduct_0 extends _i1.SmartFake implements _i2.Product {
  _FakeProduct_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProductRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductRemoteDataSource extends _i1.Mock
    implements _i3.ProductRemoteDataSource {
  MockProductRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Product> addProduct(_i2.Product? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #addProduct,
          [product],
        ),
        returnValue: _i4.Future<_i2.Product>.value(_FakeProduct_0(
          this,
          Invocation.method(
            #addProduct,
            [product],
          ),
        )),
      ) as _i4.Future<_i2.Product>);

  @override
  _i4.Future<String> deleteProduct(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteProduct,
          [id],
        ),
        returnValue: _i4.Future<String>.value(_i5.dummyValue<String>(
          this,
          Invocation.method(
            #deleteProduct,
            [id],
          ),
        )),
      ) as _i4.Future<String>);

  @override
  _i4.Future<_i2.Product> updateProduct(
    _i2.Product? product,
    String? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateProduct,
          [
            product,
            id,
          ],
        ),
        returnValue: _i4.Future<_i2.Product>.value(_FakeProduct_0(
          this,
          Invocation.method(
            #updateProduct,
            [
              product,
              id,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Product>);

  @override
  _i4.Future<_i2.Product> getProduct(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getProduct,
          [id],
        ),
        returnValue: _i4.Future<_i2.Product>.value(_FakeProduct_0(
          this,
          Invocation.method(
            #getProduct,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Product>);

  @override
  _i4.Future<List<_i2.Product>> getProducts() => (super.noSuchMethod(
        Invocation.method(
          #getProducts,
          [],
        ),
        returnValue: _i4.Future<List<_i2.Product>>.value(<_i2.Product>[]),
      ) as _i4.Future<List<_i2.Product>>);
}

/// A class which mocks [ProductLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductLocalDataSource extends _i1.Mock
    implements _i6.ProductLocalDataSource {
  MockProductLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.Product>> getAvailableProducts() => (super.noSuchMethod(
        Invocation.method(
          #getAvailableProducts,
          [],
        ),
        returnValue: _i4.Future<List<_i2.Product>>.value(<_i2.Product>[]),
      ) as _i4.Future<List<_i2.Product>>);

  @override
  _i4.Future<void> cacheProducts(List<_i2.Product>? productsToCache) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheProducts,
          [productsToCache],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i7.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
