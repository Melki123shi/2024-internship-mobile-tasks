import 'dart:io';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final int price;
  final String category;
  final int rating;
   String? image;
   File? imageFile;
  final String title;
  final String description;

  Product({
    required this.id,
    required this.price,
    required this.category,
    required this.rating,
     this.image,
     this.imageFile,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        price,
        category,
        rating,
        image,
        title,
        description,
      ];
}
