part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class Loading extends ProductState {}

final class Loaded extends ProductState {
  final Product product;

  const Loaded({required this.product});

  @override
  List<Object> get props => [product];
}

final class Error extends ProductState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
