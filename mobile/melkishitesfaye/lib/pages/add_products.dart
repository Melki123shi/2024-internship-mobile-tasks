import 'package:flutter/material.dart';
import 'package:melkishitesfaye/widget/button.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final nameController = TextEditingController();
  final catagoryController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.clear();
    catagoryController.clear();
    priceController.clear();
    descriptionController.clear();
  }

  InputDecoration inputDecoration() {
    return const InputDecoration(
      filled: true,
      fillColor: Color.fromRGBO(243, 243, 243, 1),
      contentPadding: EdgeInsets.all(8),
      border: InputBorder.none,
    );
  }

  void click() {}

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 22,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Container(
                  height: 250.0,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(243, 243, 243, 1),
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/iconImage.png',
                          width: 60,
                          height: 60,
                        ),
                        Text(
                          'upload image',
                          style: textStyle(),
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
              TextField(
                controller: nameController,
                decoration: inputDecoration(),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'catagory',
                style: textStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: catagoryController,
                decoration: inputDecoration(),
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
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(243, 243, 243, 1),
                  contentPadding: EdgeInsets.all(8),
                  suffixIcon: Icon(Icons.attach_money),
                  border: InputBorder.none,
                ),
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
              TextField(
                controller: descriptionController,
                minLines: 4,
                maxLines: 200,
                decoration: inputDecoration(),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonWidget(
                  text: 'ADD',
                  bgColor: Color.fromRGBO(63, 81, 243, 1),
                  borderColor: Color.fromRGBO(63, 81, 243, 1),
                  height: 45,
                  textColor: Colors.white,
                  width: double.infinity),
              SizedBox(
                height: 10,
              ),
              ButtonWidget(
                  text: 'DELETE',
                  bgColor: Colors.white,
                  borderColor: Color.fromRGBO(255, 19, 19, 0.79),
                  height: 45,
                  textColor: Color.fromRGBO(255, 19, 19, 0.79),
                  width: double.infinity)
            ],
          ),
        ),
      ),
    );
  }
}
