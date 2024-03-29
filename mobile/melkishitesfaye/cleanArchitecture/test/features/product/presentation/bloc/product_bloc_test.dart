import 'package:melkishitesfaye/core/util/input_converter.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/add_product_usecase.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/get_product_usecase.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/get_products_usecase.dart';
import 'package:melkishitesfaye/features/product/domain/usecases/update_product_usecase.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([GetProduct])
@GenerateMocks([GetProducts])
@GenerateMocks([AddProduct])
@GenerateMocks([UpdateProduct])
@GenerateMocks([DeleteProduct])
@GenerateMocks([InputConverter])
void main() {
  // late ProductBloc bloc;
  // late MockGetProduct mockGetProduct;
  // late MockGetProducts mockGetProducts;
  // late MockAddProduct mockAddProduct;
  // late MockUpdateProduct mockUpdateProduct;
  // late MockDeleteProduct mockDeleteProduct;
  // late InputConverter inputConverter;

//   setUp(() => {
//         // mockGetProduct = MockGetProduct(),
//         // mockGetProducts = MockGetProducts(),
//         // mockAddProduct = MockAddProduct(),
//         // mockUpdateProduct = MockUpdateProduct(),
//         // mockDeleteProduct = MockDeleteProduct(),
//         inputConverter = InputConverter(),

//         bloc = ProductBloc(
//             getProduct: mockGetProduct,
//             // getProducts: mockGetProducts,
//             // deleteProduct: mockDeleteProduct,
//             // addProduct: mockAddProduct,
//             // updateProduct: mockUpdateProduct,
//             // inputConverter: inputConverter
//             )
//       });

//   test('initialState should be Empty', () {
//     //assert
//     expect(bloc.state, equals(ProductInitial()));
//   });
}
