import 'Product.dart';

class ECommerce {
  static List<Product?> productList = [];

  void addProduct(String name, description, int price, ProductStatus status) {
    Product product = Product();
    product.setProduct(name, description, price, status);
    productList.add(product);
  }

  List<Map<String, String?>> allProduct() {
    List<Map<String, String?>> products = [];
    for (var product in productList) {
      products.add({
        'ID': product!.id,
        'Name': product.name,
        'Description': product.description,
        'Status': product.status.name,
        'Price': product.price.toString() + '\$',
      });
    }

    return products;
  }

  Map<String, String?> singleProduct(String? id) {
    if (id == null) return {'': ''};
    var foundProduct = productList.firstWhere((product) => product!.id == id,
        orElse: () => null);
    Map<String, String?> singleProduct = {
      'Name': foundProduct!.name,
      'Description': foundProduct.description,
      'Status': foundProduct.status.name,
      'Price': foundProduct.price.toString() + '\$',
    };
    return singleProduct;
  }

  void updateProduct(
      String id, String? name, description, int? price, ProductStatus? status) {
    var product = productList.firstWhere((element) => element!.id == id,
        orElse: () => null);

    if (product != null) {
      if (description != null) product.description = description;
      if (name != null) product.name = name;
      if (status != null) product.status = status;
      if (price != null) product.price = price;
    } else {
      print('Product with this id not found');
    }
  }

  void deleteProduct(String id) {
    var product = productList.firstWhere((element) => element!.id == id);
    productList.remove(product);
  }

  Map<String, String?>? compeletProducts() {
    var foundProducts = productList.firstWhere(
        (product) => product!.status == ProductStatus.Completed,
        orElse: () => null);

    if (foundProducts == null) return null;

    Map<String, String?> completeProducts = {
      'Name': foundProducts.name,
      'Description': foundProducts.description,
      'Status': foundProducts.status.name,
      'Price': foundProducts.price.toString() + '\$',
    };
    return completeProducts;
  }

  Map<String, String?>? pendingProducts() {
    var foundProducts = productList.firstWhere(
        (product) => product!.status == ProductStatus.Pending,
        orElse: () => null);

    if (foundProducts == null) return null;

    Map<String, String?> pendingProducts = {
      'Name': foundProducts.name,
      'Description': foundProducts.description,
      'Status': foundProducts.status.name,
      'Price': foundProducts.price.toString() + '\$',
    };
    return pendingProducts;
  }
}
