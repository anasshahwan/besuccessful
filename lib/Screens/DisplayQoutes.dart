import 'package:besuccessful/Screens/FavoriteQuote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:math';

class DisplayQoutes extends StatefulWidget {

  final String topicName;

  DisplayQoutes({@required this.topicName});

  static final id = 'display-qoutes';
  @override
  _DisplayQoutesState createState() => _DisplayQoutesState();
}

dynamic _random = Color(0xFFFFFFF);

class _DisplayQoutesState extends State<DisplayQoutes> {

  String topicName1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQOD(widget.topicName);
    print(widget.topicName);
    print("pl");
    getQuotesByTopicName();

    setState(() {
      _random  = Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255));
    });
  }

  void getColor(){

    setState(() {
      _random  = Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255));
    });

  }// getColor


  void getQOD(String topicName) async {
     topicName1 = topicName;
  }

  // get Update QOD

   getQuotesByTopicName() {

     Firestore.instance
         .collection('quote_topics')
         .document('$topicName1')
         .get()
         .then((DocumentSnapshot ds) {
       // use ds as a snapshot
       print(ds.data);
       print(ds.data[0]);

     });

     Firestore.instance.collection('quote_topics').where("uid",isEqualTo: widget.topicName).limit(2).getDocuments().then((snapshot) {
       snapshot.documents.forEach((snap) {
         print(snap.data);
         print("Called");

       });
     });


   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.pink,
        appBar: AppBar(title: Text("Qoutes Display .. "),),
        body: Container(child:

        new Swiper(
          itemBuilder: (BuildContext context, int index) {

            return new Card(child: Container(
              color: _random,
              child: Center(
                child: Text('$topicName1'),),
            ),);
          },
          itemCount: 1,
          itemWidth: 300,
          itemHeight: 500,
          layout: SwiperLayout.STACK,
        )
        ));
  }
}
