part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProduct extends ProductEvent {
  final String id;
  const GetProduct({required this.id});

   @override
  List<Object> get props => [id];
}

class GetProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final Product product;
  final String id;

  const AddProduct({required this.id, required this.product});

  @override
  List<Object> get props => [id, product];
}

class DeleteProduct extends ProductEvent {
  final String id;
  const DeleteProduct({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateProduct extends ProductEvent {
  final Product product;
  final String id;

  const UpdateProduct({required this.id, required this.product});

  @override
  List<Object> get props => [id, product];
}
