import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/data.dart';
import 'package:melkishitesfaye/features/product/presentatoin/pages/add_products.dart';
import 'package:melkishitesfaye/features/product/presentatoin/pages/detail.dart';
import 'package:melkishitesfaye/features/product/presentatoin/pages/home_page.dart';
import 'package:melkishitesfaye/features/product/domain/entities/product.dart';
import 'package:melkishitesfaye/features/product/presentatoin/pages/route/route_name.dart';

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

                  return MaterialPage(
                      child: DetailPage(
                    id: currproduct.id,
                    price: currproduct.price.toString(),
                    catagory: currproduct.catagory,
                    rating: currproduct.rating.toString(),
                    imageUrl: currproduct.image.toString(),
                    title: currproduct.title,
                    desciprion: currproduct.description,
                  ));
                }),
            GoRoute(
              path: 'new_product',
              name: RouteNames.newProduct,
              builder: (context, state) => AddProducts(),
            ),
            GoRoute(
              path: 'add_product/:id',
              name: RouteNames.addproduct,
              pageBuilder: (context, state) {
                  final id = state.pathParameters['id'];
                  late Product currproduct;
                  for (var product in products) {
                    if (product.id == id) {
                      currproduct = product;
                      break;
                    }
                  }

                  return MaterialPage(
                      child: AddProducts(
                    price: currproduct.price.toString(),
                    catagory: currproduct.catagory,
                    // imageUrl: currproduct.imageUrl,
                    title: currproduct.title,
                    desciprion: currproduct.description,
                  ));
                }),
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
