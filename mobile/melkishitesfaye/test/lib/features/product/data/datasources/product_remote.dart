import 'dart:convert';

import 'package:melkishitesfaye/core/error/exception.dart';
import 'package:melkishitesfaye/features/product/data/model/product_model.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  /// Calls the https://products-api-5a5n.onrender.com/apiapi/v1/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Product> addProduct(Product product);

  /// Calls the https://products-api-5a5n.onrender.com/apiapi/v1/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<String> deleteProduct(String id);

  /// Calls the https://products-api-5a5n.onrender.com/apiapi/v1/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Product> updateProduct(Product product, String id);

  /// Calls the https://products-api-5a5n.onrender.com/apiapi/v1/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Product> getProduct(String id);

  /// Calls the https://products-api-5a5n.onrender.com/apiapi/v1/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<Product>> getProducts();
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;
  final baseUri = 'https://products-api-5a5n.onrender.com/api/v1/products';

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> addProduct(Product product) async {
    final response = await client.post(
      Uri.parse('$baseUri/'),
      headers: {'Content-Type': 'application/json'},
      body: product,
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return ProductModel.fromJson(responseBody['product']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    final response = await client.get(
      Uri.parse('$baseUri/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(
      Uri.parse('$baseUri'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteProduct(String id) async {
    final response = await client.delete(
      Uri.parse('$baseUri/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "No Product found with this name";
    }
  }

  @override
  Future<ProductModel> updateProduct(Product product, String id) async {
    final response = await client.get(
      Uri.parse('$baseUri'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
