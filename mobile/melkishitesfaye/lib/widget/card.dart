import 'package:flutter/material.dart';
import 'package:melkishitesfaye/pages/detail.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  void click() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailPage()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Container(
        height: 240,
        width: 366,
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(4.0, 4.0),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  color: Color.fromARGB(255, 236, 234, 234)),
            ]),
        child: Column(children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image.asset(
              'assets/images/imges.jpeg',
              width: double.infinity,
              height: 160,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Derby Leather Shoes',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(62, 62, 62, 1)),
                ),
                Row(
                  children: [
                    Icon(Icons.attach_money),
                    Text(
                      '120',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(62, 62, 62, 1)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Men's shoe",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(170, 170, 170, 1)),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Color.fromRGBO(255, 216, 0, 1),
                    ),
                    Text(
                      '(4.0)',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(170, 170, 170, 1)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
