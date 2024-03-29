import 'package:flutter/material.dart';

class TextFieldFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const TextFieldFormWidget({
    super.key,
    required this.controller,
    this.validator,
  });

  InputDecoration inputDecoration() {
    return const InputDecoration(
      filled: true,
      fillColor: Color.fromRGBO(243, 243, 243, 1),
      contentPadding: EdgeInsets.all(8),
      border: InputBorder.none,
      // errorBorder: OutlineInputBorder(
      //   borderSide: BorderSide(
      //     color: Colors.red, // Change border color on error
      //   ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: inputDecoration(),
      validator: validator,
    );
  }
}
