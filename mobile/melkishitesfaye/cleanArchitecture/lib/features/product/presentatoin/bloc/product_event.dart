part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductEvent extends ProductEvent {
  final String id;
  const GetProductEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetProductsEvent extends ProductEvent {
  GetProductsEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends ProductEvent {
  final Product product;

  const AddProductEvent({
    required this.product,
  });

  @override
  List<Object> get props => [
        product,
      ];
}

class DeleteProductEvent extends ProductEvent {
  final String id;
  const DeleteProductEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  final String id;

  const UpdateProductEvent({required this.id, required this.product});

  @override
  List<Object> get props => [id, product];
}

class GetFilteredProductsEvent extends ProductEvent {
  final String title;
  GetFilteredProductsEvent({required this.title});

  @override
  List<Object> get props => [title];
}
