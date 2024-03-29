import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:melkishitesfaye/core/error/exception.dart';
import 'package:melkishitesfaye/features/product/data/model/product_model.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  /// Calls the https://products-api-5a5n.onrender.com/apiapi/v1/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Product> addProduct(ProductModel product);

  /// Calls the https://products-api-5a5n.onrender.com/apiapi/v1/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<String> deleteProduct(String id);

  /// Calls the https://products-api-5a5n.onrender.com/apiapi/v1/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Product> updateProduct(ProductModel product, String id);

  /// Calls the https://products-api-5a5n.onrender.com/apiapi/v1/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Product> getProduct(String id);

  /// Calls the https://products-api-5a5n.onrender.com/apiapi/v1/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;
  final baseUrl = 'https://products-api-5a5n.onrender.com/api/v1/products';

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    var url = Uri.parse('$baseUrl');
    var request = http.MultipartRequest('POST', url);
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields["title"] = product.title;
    request.fields["description"] = product.description;
    request.fields["category"] = product.category;
    request.fields["price"] = product.price.toString();
    if (product.imageFile != null) {
      var multipartImage = http.MultipartFile.fromBytes(
        contentType: MediaType('image', 'jpeg'),
        "images",
        File(product.imageFile!.path).readAsBytesSync(),
        filename: "product1.PNG",
      );
      request.files.add(multipartImage);
    }
    var imageByteLength = request.contentLength;
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    request.headers.addAll(headers);
    final response = await request.send();
    var res = await http.Response.fromStream(response);

    if (res.statusCode == 201) {
      return ProductModel.fromJson(json.decode(res.body)["product"]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['product']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(
      Uri.parse('$baseUrl'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> jsonList = data['products'];
      final res = jsonList.map((json) => ProductModel.fromJson(json)).toList();
      return res;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteProduct(String id) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "No Product found with this name";
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product, String id) async {
    var url = Uri.parse('$baseUrl/$id');
    var request = http.MultipartRequest('PATCH', url);
    // request.fields["_id"] = product.id;
    request.fields["title"] = product.title;
    request.fields["description"] = product.description;
    request.fields["category"] = product.category;
    request.fields["price"] = product.price.toString();
    print(product.imageFile);
    if (product.imageFile != null) {
      var multipartImage = http.MultipartFile.fromBytes(
        contentType:
            MediaType('image', product.imageFile!.path.split(".").last),
        "images",
        File(product.imageFile!.path).readAsBytesSync(),
        filename: product.imageFile!.path,
      );
      request.files.add(multipartImage);
    } else {
      request.fields["image"] = product.image!;
    }
    var imageByteLength = request.contentLength;
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    request.headers.addAll(headers);
    final response = await request.send();
    var res = await http.Response.fromStream(response);

    if (res.statusCode == 200) {
      final result = json.decode(res.body)["product"];
      print(result);
      return ProductModel.fromJson(result);
    } else {
      throw ServerException();
    }
  }
}
