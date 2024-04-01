import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:melkishitesfaye/core/error/exception.dart';
import 'package:melkishitesfaye/core/network/network_info.dart';
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

  /// Calls the https://products-api-5a5n.onrender.com/apiapi/v1/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> getFilteredProducts(String title);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;
  final baseUrl = 'https://products-api-5a5n.onrender.com/api/v1/products';

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    var url = Uri.parse('$baseUrl');
    var request = http.MultipartRequest('POST', url);
    request.fields["title"] = product.title;
    request.fields["price"] = product.price.toString();
    request.fields["description"] = product.description;
    request.fields["category"] = product.category;
    request.headers["Content-Type"] = 'multipart/form-data';

    if (product.imageFile != null) {
      print(product.imageFile);
      var fileStream =
          http.ByteStream(Stream.castFrom(product.imageFile!.openRead()));
      final imageLength = await product.imageFile!.length();
      final imageUpload = http.MultipartFile(
        'image',
        fileStream,
        imageLength,
        filename: 'product_image.jpeg',
      );
      request.files.add(imageUpload);
    }

    final response = await request.send();
    print(response);
    if (response.statusCode == 201) {
      var responseBody = await response.stream.bytesToString();
      return ProductModel.fromJson(json.decode(responseBody)['product']);
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
    request.fields["title"] = product.title;
    request.fields["description"] = product.description;
    request.fields["category"] = product.category;
    request.fields["price"] = product.price.toString();
    if (product.imageFile != null) {
      var multipartImage = http.MultipartFile.fromBytes(
        "images",
        File(product.imageFile!.path).readAsBytesSync(),
        filename: product.imageFile!.path,
        contentType:
            MediaType('image', product.imageFile!.path.split(".").last),
      );
      print(multipartImage);
      request.files.add(multipartImage);
    } else {
      request.fields["image"] = product.image!;
    }
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data; charset=UTF-8',
    };

    request.headers.addAll(headers);
    final response = await request.send();
    var res = await http.Response.fromStream(response);

    if (res.statusCode == 200) {
      final result = json.decode(res.body)["product"];
      return ProductModel.fromJson(result);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getFilteredProducts(String searchQuery) async {
    Uri url = Uri.parse('${baseUrl}');
    Map<String, dynamic> queryParams = {};

    if (searchQuery.isNotEmpty) {
      queryParams['title'] = searchQuery;
    }
    url = url.replace(queryParameters: queryParams);

    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> productsJson = responseData['products'];
      final res =
          productsJson.map((json) => ProductModel.fromJson(json)).toList();
      return res;
    } else {
      throw ServerException();
    }
  }
}
