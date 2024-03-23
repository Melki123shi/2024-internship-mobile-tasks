import 'dart:convert';

import 'package:melkishitesfaye/core/error/exception.dart';
import 'package:melkishitesfaye/features/product/data/model/product_model.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDataSource {
  /// Gets the cached [List<ProductModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<Product>> getAvailableProducts();

  Future<void> cacheProducts(List<Product> productsToCache);
}

const CACHED_PRODUCTS = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<Product>> getAvailableProducts() async {
    final jsonStrings = await sharedPreferences.getStringList(CACHED_PRODUCTS);
    if (jsonStrings != null) {
      return Future.value(jsonStrings.map((jsonString) {
        return ProductModel.fromJson(json.decode(jsonString));
      }).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(List<Product> productsToCache) {
    return sharedPreferences.setString(
      CACHED_PRODUCTS,
      json.encode(productsToCache),
    );
  }
}
