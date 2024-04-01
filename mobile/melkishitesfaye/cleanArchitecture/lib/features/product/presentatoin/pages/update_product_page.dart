import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_name.dart';
import '../widget/button.dart';
import '../../../../core/util/pick_image.dart';
import '../../data/model/product_model.dart';
import '../bloc/product_bloc.dart';

final _formKey = GlobalKey<FormState>();

class UpdatePage extends StatefulWidget {
  final String id;
  final String title;
  final String category;
  final String price;
  final String description;
  final String? image;

  const UpdatePage({
    super.key,
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    required this.image,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? imageFile;

  @override
  void dispose() {
    super.dispose();
    _titleController.clear();
    _categoryController.clear();
    _priceController.clear();
    _descriptionController.clear();
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _categoryController.text = widget.category;
    _priceController.text = widget.price;
    _descriptionController.text = widget.description;
    // image =
    //     "https://media.istockphoto.com/id/1136422297/photo/face-cream-serum-lotion-moisturizer-and-sea-salt-among-bamboo-leaves.jpg?s=612x612&w=0&k=20&c=mwzWVrDvJTkHlVf-8RL49Hs5xjuv1TrYcBW4DnWVt-0=";
  }

  void selectedImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        imageFile = pickedImage;
      });
    }
  }

  void updateProdcut(BuildContext context) {
    final product = ProductModel(
      id: widget.id,
      price: int.parse(_priceController.text),
      category: _categoryController.text,
      rating: 0,
      image:
          'https://media.istockphoto.com/id/1136422297/photo/face-cream-serum-lotion-moisturizer-and-sea-salt-among-bamboo-leaves.jpg?s=612x612&w=0&k=20&c=mwzWVrDvJTkHlVf-8RL49Hs5xjuv1TrYcBW4DnWVt-0=',
      imageFile: imageFile,
      title: _titleController.text,
      description: _descriptionController.text,
    );
    context.read<ProductBloc>().add(
          UpdateProductEvent(
            product: product,
            id: widget.id,
          ),
        );
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
          'Update Product',
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
            onPressed: () {
              context.goNamed(RouteNames.detail,
                  pathParameters: {'id': widget.id});
            },
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
            if (state is FailureState) {
              const Center(child: Text('error occured in the uodate page'));
            }
          },
          builder: (context, state) {
            if (state is UpdateProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            print(state);
            if (state is SucessUpdateProduct) {
              return const Center(
                child: Text('Succesflully Updated'),
              );
            }

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: selectedImage,
                      child: Container(
                        height: 190.0,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(243, 243, 243, 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Stack(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              if (imageFile != null)
                                Center(
                                  child: Image.file(
                                    imageFile!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              if (imageFile == null)
                                Image.network(
                                  widget.image!,
                                  fit: BoxFit.fill,
                                ),
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
                      controller: _titleController,
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
                      controller: _categoryController,
                      decoration: inputDecoration(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: categoryValidation,
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
                      controller: _priceController,
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
                      controller: _descriptionController,
                      minLines: 4,
                      decoration: inputDecoration(),
                      maxLines: null, // Allow unlimited lines
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            updateProdcut(context);
                          }
                        },
                        text: 'UPDATE',
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
