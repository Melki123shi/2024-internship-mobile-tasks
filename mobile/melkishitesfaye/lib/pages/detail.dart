import 'package:flutter/material.dart';
import 'package:melkishitesfaye/widget/button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
      backgroundColor: Color.fromRGBO(254, 254, 254, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/imges.jpeg',
              width: double.infinity,
              height: 286,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 8, 30, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Men's shoe",
                        style: TextStyle(
                            fontSize: 16,
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
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(170, 170, 170, 1)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Derby Leather',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(62, 62, 62, 1)),
                      ),
                      Row(
                        children: [
                          Icon(Icons.attach_money),
                          Text(
                            '120',
                            style: TextStyle(
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
                                  padding: const EdgeInsets.all(12),
                                  child: Center(
                                    child: Text(
                                      (index + currentNumber).toString(),
                                      style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(4.0, 4.0),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                        color:
                                            Color.fromARGB(255, 236, 234, 234)),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                  color: isSelected ? Color.fromRGBO(63, 81, 243, 1): Colors.white,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
                    style: TextStyle(
                      color: Color.fromRGBO(102, 102, 102, 1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                          text: 'DELETE',
                          bgColor: Colors.white,
                          borderColor: Color.fromRGBO(255, 19, 19, 0.79),
                          height: 50,
                          textColor: Color.fromRGBO(255, 19, 19, 0.79),
                          width: 152),
                      ButtonWidget(
                          text: 'UPDATE',
                          bgColor: Color.fromRGBO(63, 81, 243, 1),
                          borderColor: Color.fromRGBO(63, 81, 243, 1),
                          height: 50,
                          textColor: Color.fromRGBO(255, 255, 255, 0.79),
                          width: 152)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
