import 'package:melkishitesfaye/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required String id,
    required double price,
    required String catagory,
    required double rating,
    required String image,
    required String title,
    required String description,
  }) : super(
          id: id,
          price: price,
          catagory: catagory,
          rating: rating,
          image: image,
          title: title,
          description: description,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      catagory: json['category'],
      rating: (json['rating'] != null) ? double.tryParse(json['rating']['rate'].toString()) ?? 0.0 : 0.0,
      image: json['image'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'category': catagory,
      'rating': {'rate': rating, 'count': 0},
      'image': image,
      'title': title,
      'description': description,
    };
  }
}
