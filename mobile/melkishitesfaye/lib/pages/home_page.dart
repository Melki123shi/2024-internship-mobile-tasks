import 'package:flutter/material.dart';
import 'package:melkishitesfaye/pages/add_products.dart';
import 'package:melkishitesfaye/widget/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int list = 6;
  void click() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddProducts()));
  }

  @override
  Widget build(BuildContext context) {
    void notification() {}
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 254, 254, 1),
      floatingActionButton: FloatingActionButton(
        onPressed: click,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'July 14, 2023',
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
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text('Available Products',style: TextStyle(
                color: Color.fromRGBO(62, 62, 62, 1),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(
                height: 900,
                child: ListView.builder(
                  itemCount: list,
                  itemBuilder: (context, index) {
                    return const CardWidget();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
