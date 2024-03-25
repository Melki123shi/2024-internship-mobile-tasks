import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';

import '../../../../core/util/input_converter.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  late final GetProduct getConcreteNumberTrivia;
  late final GetProducts getRandomNumberTrivia;
  late final InputConverter inputConverter;

  ProductBloc({
    required GetProduct getProduct,
    required GetProducts getProducts,
    required DeleteProduct deleteProduct,
    required AddProduct addProduct,
    required UpdateProduct updateProduct,
    required this.inputConverter,
  })  : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

}
