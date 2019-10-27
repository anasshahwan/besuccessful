import 'package:flutter/material.dart';


class QouteCategories extends StatefulWidget {
  static final id = 'qoute-categories';
  @override
  _QouteCategoriesState createState() => _QouteCategoriesState();
}

class _QouteCategoriesState extends State<QouteCategories> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Full Width Drawer Example"),
      ),
      drawer: SizedBox(
        width: size.width,
        child: Drawer(
          child: Container(
          ),
        ),
      ),
      body: Center(
        child: Text('Main Body'),
      ),
    );
  }
}
