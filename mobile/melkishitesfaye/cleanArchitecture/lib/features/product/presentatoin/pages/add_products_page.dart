import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widget/button.dart';

// import '../../../../core/common/widgets/loader.dart';
import '../../../../core/util/pick_image.dart';
import '../../data/model/product_model.dart';
import '../bloc/product_bloc.dart';

final _formKey = GlobalKey<FormState>();

class AddProducts extends StatefulWidget {
  const AddProducts({
    super.key,
  });

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  File? imageFile;

  @override
  void dispose() {
    super.dispose();
    titleController.clear();
    categoryController.clear();
    priceController.clear();
    descriptionController.clear();
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
      });
    }
  }

  void addProdcut(BuildContext context) {
    final product = ProductModel(
      id: '456',
      price: int.parse(priceController.text),
      category: categoryController.text,
      rating: 0,
      imageFile: imageFile,
      title: titleController.text,
      description: descriptionController.text,
    );
    context.read<ProductBloc>().add(AddProductEvent(product: product));
  }

  String? titleValidation(String? name) {
    if (name!.length < 3) {
      return 'name must be atleast 3 characters long';
    }
    return null;
  }

  String? categoryValidation(String? category) {
    if (category!.length < 3) {
      return 'category must be atleast 3 characters long';
    }
  }

  String? priceValidator(String? price) {
    if (price == null) return 'price can not be empty';

    try {
      int.parse(price);
    } catch (e) {
      return 'invalid price';
    }
  }

  InputDecoration inputDecoration() {
    return const InputDecoration(
      filled: true,
      fillColor: Color.fromRGBO(243, 243, 243, 1),
      contentPadding: EdgeInsets.all(8),
      border: InputBorder.none,
    );
  }

  TextStyle textStyle() {
    return const TextStyle(fontWeight: FontWeight.w800);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Add Product',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        )),
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            color: Color.fromRGBO(63, 81, 243, 1),
            onPressed: () => context.go('/'),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 22,
        ),
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            print(state);
            if (state is FailureState) {
              const Center(child: Text('error occured'));
            }
          },
          builder: (context, state) {
            if (state is AddProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SucessAddProduct) {
              return const Center(
                child: Text('Succesflully added'),
              );
            }
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageFile != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    imageFile!.path,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImage,
                            child: Container(
                              height: 250.0,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(243, 243, 243, 1),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child: Image.asset(
                                          'assets/images/iconImage.png')),
                                  Center(
                                    child: Text(
                                      'upload image',
                                      style: textStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'name',
                      style: textStyle(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: inputDecoration(),
                      validator: titleValidation,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'category',
                      style: textStyle(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: categoryController,
                      decoration: inputDecoration(),
                      validator: categoryValidation,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'price',
                      style: textStyle(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(243, 243, 243, 1),
                        contentPadding: EdgeInsets.all(8),
                        suffixIcon: Icon(Icons.attach_money),
                        border: InputBorder.none,
                      ),
                      validator: priceValidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Description',
                      style: textStyle(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: null, // Allow unlimited lines
                      keyboardType: TextInputType.multiline,
                      controller: descriptionController,
                      minLines: 4,
                      decoration: inputDecoration(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            addProdcut(context);
                          }
                        },
                        text: 'ADD',
                        bgColor: Color.fromRGBO(63, 81, 243, 1),
                        borderColor: Color.fromRGBO(63, 81, 243, 1),
                        height: 45,
                        textColor: Colors.white,
                        width: double.infinity),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonWidget(
                        onTap: () => dispose(),
                        text: 'CLEAR',
                        bgColor: Colors.white,
                        borderColor: Color.fromRGBO(255, 19, 19, 0.79),
                        height: 45,
                        textColor: Color.fromRGBO(255, 19, 19, 0.79),
                        width: double.infinity)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
