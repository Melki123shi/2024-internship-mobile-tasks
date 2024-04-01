import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../bloc/product_bloc.dart';
import '../../domain/entities/product.dart';
import '../../../../core/routing/route_name.dart';
import '../widget/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    void notification() {}
    String currentDateTime =
        DateFormat.yMMMMd().add_Hms().format(DateTime.now());
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 254, 254, 1),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(RouteNames.newProduct),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentDateTime,
              style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 153, 153, 153),
                  fontFamily: AutofillHints.familyName),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text('Hello, '),
                Text('Yohannes'),
              ],
            )
          ],
        ),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1.0,
                ),
              ],
            ),
            child: IconButton(
              onPressed: notification,
              icon: const Icon(
                Icons.notifications_none_outlined,
              ),
            ),
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
//
          )
        ],
        leading: Container(
          child: Image.asset('assets/images/logo.jpeg'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Available Products',
                    style: TextStyle(
                      color: Color.fromRGBO(62, 62, 62, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(0.2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color.fromARGB(255, 253, 253, 253),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.goNamed(
                          RouteNames.searchProduct,
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
//
                  )
                ],
              ),
              BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is FailureState) {
                    Center(child: Text("error occured"));
                  }
                },
                builder: (context, state) {
                  if (state is GetProductsLoading) {
                    return const Column(
                      children: [
                        SizedBox(
                          height: 250,
                        ),
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  }
                  if (state is SucessLoadProducts) {
                    //  return SizedBox(
                    //   height: 1000,
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
                  }
                  return const SizedBox(
                    child: Center(
                      child: Text('No products found'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
