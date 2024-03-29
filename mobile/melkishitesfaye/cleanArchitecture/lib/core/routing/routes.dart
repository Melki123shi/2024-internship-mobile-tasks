import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:melkishitesfaye/features/product/presentatoin/pages/add_products.dart';
import 'package:melkishitesfaye/features/product/presentatoin/pages/detail.dart';
import 'package:melkishitesfaye/features/product/presentatoin/pages/home_page.dart';
import 'package:melkishitesfaye/core/routing/route_name.dart';
import 'package:melkishitesfaye/features/product/presentatoin/pages/update_page_try.dart';

class RouteConfig {
  static GoRouter returnRouter() {
    return GoRouter(
      errorBuilder: ((context, state) => Scaffold(
            body: Center(
                child: Text(
                    'Error occured while loading this page please try agin')),
          )),
      routes: [
        GoRoute(
          name: RouteNames.home,
          path: '/',
          pageBuilder: (context, state) =>
              const MaterialPage(child: HomePage()),
        ),
        // routes: [
        GoRoute(
            name: RouteNames.detail,
            path: '/details/:id',
            pageBuilder: (context, state) {
              final id = state.pathParameters['id']!;
              return MaterialPage(
                  child: DetailPage(
                id: id,
              ));
            }),
        GoRoute(
          path: '/new_product',
          name: RouteNames.newProduct,
          pageBuilder: (context, state) => MaterialPage(child: AddProducts()),
        ),
        GoRoute(
            path: '/update_product/:id',
            name: RouteNames.updateroduct,
            pageBuilder: (context, state) {
              final id = state.pathParameters['id']!;
              final Map<String, dynamic> params = state.uri.queryParameters;

              final title = params['title'];
              final description = params['description'];
              final price = params['price'];
              final category = params['category'];
              final image = params['image'];
              return MaterialPage(
                  child: UpdatePage(
                id: id,
                title: title ?? '',
                description: description ?? '',
                price: price ?? '0.0',
                category: category ?? '',
                image: image,
              ));
            }),
        // ],
        // )
      ],
    );
  }
}
