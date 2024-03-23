import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final String price;
  final String productType;
  final String rating;
  final String imageUrl;
  final String productName;

  const CardWidget({
    super.key,
    required this.price,
    required this.productType,
    required this.rating,
    required this.imageUrl,
    required this.productName,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 340,
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
              color: Color.fromARGB(255, 236, 234, 234),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                widget.imageUrl,
                width: double.infinity,
                height: 260,
                fit: BoxFit.fitWidth,
              ),
            ),
            
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.productName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(62, 62, 62, 1),
                    ),
                  ),
                  
                  Row(
                    children: [
                      const Icon(Icons.attach_money),
                      Text(
                        widget.price, // Remove quotes and toString()
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(62, 62, 62, 1),
                        ),
                      ),
                    ],
                  ),
                
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.productType, // Correct usage of enum
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(170, 170, 170, 1),
                    ),
                  ),
                 
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color.fromRGBO(255, 216, 0, 1),
                      ),
                      Text(
                        widget.rating,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(170, 170, 170, 1),
                        ),
                      ),
                    ],
                  ),
                
                ],
              ),
            ),
         
          ],
        ),
    );

  }
}
