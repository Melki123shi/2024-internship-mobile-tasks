import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_name.dart';
import '../widget/button.dart';
import '../bloc/product_bloc.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductEvent(id: widget.id));
  }

  void deleteProduct() {
    context.read<ProductBloc>().add(DeleteProductEvent(id: widget.id));
  }

  int currentNumber = 32;
  int selectedIndex = 0;

  void tapped(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: const Color.fromRGBO(63, 81, 243, 1),
            onPressed: () => context.goNamed(RouteNames.home),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(254, 254, 254, 1),
      body: BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
        if (state is FailureState) {
          const Center(child: Text("error occured"));
        }
      }, builder: (context, state) {
        if (state is GetSingleProductLoading) {
          return const  Center(
          child: CircularProgressIndicator(),
        );
        }
        if (state is SucessLoadSingleProduct) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 300,
                  child: Image.network(
                    state.product.image!,
                    width: double.infinity,
                    height: 206,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 30, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.product.category,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(170, 170, 170, 1)),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color.fromRGBO(255, 216, 0, 1),
                                  ),
                                  Text(
                                    state.product.rating.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromRGBO(170, 170, 170, 1)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.product.title,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(62, 62, 62, 1)),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.attach_money),
                                  Text(
                                    state.product.price.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(62, 62, 62, 1)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Size:',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(62, 62, 62, 1)),
                          ),
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 7,
                                itemBuilder: (context, index) {
                                  bool isSelected = (index == selectedIndex);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () => tapped(index),
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        child: Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Center(
                                            child: Text(
                                              (index + currentNumber)
                                                  .toString(),
                                              style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(4.0, 4.0),
                                                blurRadius: 1.0,
                                                spreadRadius: 1.0,
                                                color: Color.fromARGB(
                                                    255, 236, 234, 234)),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: isSelected
                                              ? const Color.fromRGBO(
                                                  63, 81, 243, 1)
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            state.product.description,
                            style: const TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                  
                        children: [
                          ButtonWidget(
                              onTap: deleteProduct,
                              text: 'DELETE',
                              bgColor: Colors.white,
                              borderColor:
                                  const Color.fromRGBO(255, 19, 19, 0.79),
                              height: 50,
                              textColor:
                                  const Color.fromRGBO(255, 19, 19, 0.79),
                              width: 92),
                          ButtonWidget(
                            onTap: () {
                              context.goNamed(RouteNames.updateroduct,
                                  pathParameters: {
                                    'id': widget.id
                                  },
                                  queryParameters: {
                                    'title': state.product.title,
                                    'description': state.product.description,
                                    'price': state.product.price.toString(),
                                    'category': state.product.category,
                                    'image':state.product.image,
                                  });
                            },
                            text: 'UPDATE',
                            bgColor: const Color.fromRGBO(63, 81, 243, 1),
                            borderColor: const Color.fromRGBO(63, 81, 243, 1),
                            height: 50,
                            textColor:
                                const Color.fromRGBO(255, 255, 255, 0.79),
                            width: 92,
                          )
                        ],
                      )
                   
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        if (state is DeleteProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SucessDeleteProduct) {
          return const Center(child: Text('Product Deleted Succesfully'));
        }
        return const Center(child: Text('Error ocurred'));
      }),
    );
  }
}
