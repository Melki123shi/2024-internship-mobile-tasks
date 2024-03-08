import 'dart:io';

import 'Product.dart';
import 'eCommerce.dart';

void main() {
  // Intializing ECommerce
  ECommerce ecommerce = ECommerce();

  // Ask a user to choose the choices
  stdout.writeln('''
Hi welcome!!! Please enter a command

1. View all products     2. Add a product   3. Display single product
4. Update Product        5. Remove Product  6. View completed Products
7. View Pending Products Ctr - c. exit
''');
  // var input = stdin.readLineSync();
  final validInputs = ['1', '2', '3', '4', '5', '6', '7'];
  final validStatus = ['1', '2'];

  var input = stdin.readLineSync();

  while (validInputs.contains(input)) {
    switch (input) {
      case '1':
        {
          // View all products
          print(ecommerce.allProduct());
          print('\n');
          break;
        }

      case '2':
        {
          // Adding Products
          stdout.writeln('Input Product name: ');
          var name = (stdin.readLineSync() ?? 'None');

          stdout.writeln('Input Product description: ');
          var description = (stdin.readLineSync() ?? 'None');

          stdout.writeln('Input Product price: ');
          var price = int.parse(stdin.readLineSync() ?? '0');

          stdout.writeln('''
            Choose Product status: 
            1. Pending           2. completed
          ''');
          var statusNumber = stdin.readLineSync() ?? '1';
          if (validStatus.contains(statusNumber)) {
            var status = ProductStatus.Pending;
            if (statusNumber == '2') {
              status = ProductStatus.Completed;
            }
            ecommerce.addProduct(name, description, price, status);
          }
          break;
        }

      case '3':
        {
          // Displaying a single product
          stdout.writeln('Input Product id: ');
          var id = stdin.readLineSync();
          if (id == null)
            print('Please enter start agian and enter a valid id');
          else {
            Map<String, String?> singleproduct = ecommerce.singleProduct(id);
            print('Displaying single product with an id $id');
            print(singleproduct);
            print('\n');
          }
          break;
        }

      case '4':
        {
          // Updating Products
          stdout.writeln('Input Product id: ');
          var id = stdin.readLineSync();
          if (id == null)
            print('Please enter start agian and enter a valid id');
          else {
            stdout.writeln('Input Product name: ');
            var name = stdin.readLineSync() ?? null;

            stdout.writeln('Input Product description: ');
            var description = (stdin.readLineSync() ?? null);

            stdout.writeln('Input Product price: ');
            var price = int.parse(stdin.readLineSync() ?? '0');

            stdout.writeln('''
Choose Product status: 
1. Pending           2. completed
          ''');
            var status = (stdin.readLineSync() ?? ProductStatus.Pending)
                as ProductStatus;
            if (validStatus.contains(status)) {
              ecommerce.updateProduct(id, name, description, price, status);
            } else
              print('invalid Status');
          }
          break;
        }

      case '5':
        {
          // Delete a Product
          stdout.writeln('Input Product id: ');
          var id = stdin.readLineSync();
          if (id == null)
            print('Please enter start agian and enter a valid id');
          else {
            ecommerce.deleteProduct(id);
          }
          break;
        }

      case '6':
        {
          // Displaying a completed product
          Map<String, String?>? compeletProducts = ecommerce.compeletProducts();
          if (compeletProducts == null) {
            print('No element');
          }
          else {
            print('Displaying completed products');
            print(compeletProducts);
            print('\n');
          }
          break;
        }

      case '7':
        {
          // Displaying a completed product
          Map<String, String?>? pendingProducts = ecommerce.pendingProducts();
           if (pendingProducts == null) {
            print('No element');
          }
          else {
            print('Displaying pending products');
            print(pendingProducts);
            print('\n');
          }
          break;
        }
      default:
        break;
    }

    stdout.writeln('Choose again!!!');
    stdout.writeln('''
Hi welcome!!! Please enter a command

1. View all products     2. Add a product   3. Display single product
4. Update Product        5. Remove Product  6. View completed Products
7. View Pending Products Ctr - c. exit
  ''');
      print('\n');
      input = stdin.readLineSync();
  }
}
