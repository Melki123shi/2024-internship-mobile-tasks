import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final double price;
  final String catagory;
  final double rating;
  final String image;
  final String title;
  final String description;

  const Product({
    required this.id,
    required this.price,
    required this.catagory,
    required this.rating,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        price,
        catagory,
        rating,
        image,
        title,
        description,
      ];
}


