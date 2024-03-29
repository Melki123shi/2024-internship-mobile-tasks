import 'dart:io';

import 'package:melkishitesfaye/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required double price,
    required String category,
    required double rating,
     String? image,
     File? imageFile,
    required String title,
    required String description,
  }) : super(
          id: id,
          price: price,
          category: category,
          rating: rating,
          image: image,
          title: title,
          description: description,
          imageFile: imageFile,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      price: json['price'],
      category: json['category'],
      rating: json['rating']['rate'],
      image: json['image'],
      title: json['title'],
      description: json['description'],
     imageFile: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'category': category,
      'rating': {'rate': rating, 'count': 0},
      'image': image,
      'title': title,
      'description': description,
    };
  }

  ProductModel copyWith({
    String? id,
    double? price,
    String? category,
    double? rating,
    String? image,
    String? title,
    String? description,
    File? imagePath,
  }) {
    return ProductModel(
      id: id ?? this.id,
      price: price ?? this.price,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      imageFile: imageFile ?? imageFile,
    );
  }
}
