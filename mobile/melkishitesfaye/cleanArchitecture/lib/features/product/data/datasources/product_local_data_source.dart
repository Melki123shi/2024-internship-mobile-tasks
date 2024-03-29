import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import '../../../../core/error/exception.dart';
import '../model/product_model.dart';

abstract class ProductLocalDataSource {
  /// Gets the cached [ProductModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws a [NoLocalDataException] if no cached data is present.
  Future<List<ProductModel>> getAvailableProducts();

  /// cache [ProductModel] when the user has
  /// good  internet connection.
  ///
  /// Throws a [CacheException] if can't
  Future<void> cacheProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getAvailableProducts() async {
    final jsonString = sharedPreferences.getString('CACHED_PRODUCT');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);

      final res = jsonList.map((json) => ProductModel.fromJson(json)).toList();
      return res;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final List<Map<String, dynamic>> jsonList =
        products.map((product) => product.toJson()).toList();
    final jsonString = json.encode(jsonList);

    await sharedPreferences.setString('CACHED_PRODUCT', jsonString);
  }
}
