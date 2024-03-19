import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:melkishitesfaye/data/data.dart';
import 'package:melkishitesfaye/model/product.dart';
import 'package:melkishitesfaye/pages/add_products.dart';
import 'package:melkishitesfaye/pages/detail.dart';
import 'package:melkishitesfaye/pages/home_page.dart';
import 'package:melkishitesfaye/route/route_name.dart';

class RouteConfig {
  static GoRouter returnRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          name: RouteNames.home,
          path: '/',
          pageBuilder: (context, state) =>
              const MaterialPage(child: HomePage()),
          routes: [
            GoRoute(
                name: RouteNames.detail,
                path: 'details/:id',
                pageBuilder: (context, state) {
                  final id = state.pathParameters['id'];
                  late Product currproduct;
                  for (var product in products) {
                    if (product.id == id) {
                      currproduct = product;
                      break;
                    }
                  }

                  print(currproduct.id);
                  return MaterialPage(
                      child: DetailPage(
                    price: currproduct.price,
                    productType: currproduct.productType,
                    rating: currproduct.rating,
                    imageUrl: currproduct.imageUrl,
                    productName: currproduct.productName,
                  ));
                }),
            GoRoute(
              path: 'add_product',
              name: RouteNames.addproduct,
              builder: (context, state) => const AddProducts(),
            ),
          ],
        )
      ],
      errorBuilder: ((context, state) => Scaffold(
            body: Center(
                child: Text(
                    'Error occured while loading this page please try agin')),
          )),
    );
  }
}
