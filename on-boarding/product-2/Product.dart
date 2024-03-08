enum ProductStatus { Completed, Pending }

class Product {
  static int _nextId = 1;
  String? id, name, description;
  var status = ProductStatus.Pending;
  int? price;

  void setProduct(String name, description, int price, ProductStatus status) {
    this.id = '$_nextId';
    _nextId++;
    this.name = name;
    this.description = description;
    this.status = status;
    this.price = price;
  }
}
