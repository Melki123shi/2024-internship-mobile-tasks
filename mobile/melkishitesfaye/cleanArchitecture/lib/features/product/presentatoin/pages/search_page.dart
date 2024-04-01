import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_name.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widget/card.dart';

class SearchPage extends StatefulWidget {
  final String title;

  const SearchPage({Key? key, required this.title}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  void filtered() {
    context
        .read<ProductBloc>()
        .add(GetFilteredProductsEvent(title: widget.title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () {}, // Replace null with your filter logic
                  icon: Icon(Icons.filter_list),
                ),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  onPressed: filtered,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is FailureState) {
                  Center(child: Text("Error occurred"));
                }
              },
              builder: (context, state) {
                if (state is GetFilteredProductsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SucessLoadFilteredProducts) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      Product foundProduct = state.products[index];
                      return GestureDetector(
                        onTap: () {
                          context.goNamed(RouteNames.detail,
                              pathParameters: {'id': foundProduct.id});
                        },
                        child: CardWidget(
                          price: foundProduct.price.toString(),
                          catagory: foundProduct.category,
                          rating: foundProduct.rating.toString(),
                          image: foundProduct.image.toString(),
                          title: foundProduct.title,
                        ),
                      );
                    },
                    // ),
                  );
                } else {
                  return Center(child: Text('No products found'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
