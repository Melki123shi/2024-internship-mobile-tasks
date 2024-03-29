import 'package:flutter/material.dart';

class ProductsShowLoader extends StatelessWidget {
  const ProductsShowLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
             child: CircularProgressIndicator(),
    );
  }
}