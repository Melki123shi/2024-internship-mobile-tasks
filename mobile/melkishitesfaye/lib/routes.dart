import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:melkishitesfaye/pages/add_products.dart';
import 'package:melkishitesfaye/pages/detail.dart';
import 'package:melkishitesfaye/pages/home_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const HomePage(),
      
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) => const DetailPage()
        ),
        GoRoute(
          path: 'add_products',
          builder: (BuildContext context, GoRouterState state) => const AddProducts()
        ),
      ],
    ),
  ],
);