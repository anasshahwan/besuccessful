import 'dart:convert';

import 'package:besuccessful/Screens/FavoriteQuote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:math';
import '../CustomWidgets/ButtonIcon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    // getQOD(widget.topicName);
  //  print(widget.topicName);
    getQuotesByTopicName();
    print(widget.topicName);

  }

  void getColor() {
    setState(() {
      _random = Color.fromARGB(
          255, Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255));
    });
  } // getColor


  void getQOD(String topicName) async {
    topicName1 = topicName;
  }

  // get Update QOD

  Future getQuotesByTopicName() async{
      var topcName = widget.topicName;

    var firestore = Firestore.instance;

    var  qn =  await firestore.collection('quote_topics').document(topcName).get();
    return qn;
//    Firestore.instance
//        .collection('quote_topics')
//        .document('$topicName1')
//        .get()
//        .then((DocumentSnapshot ds) {
//      // use ds as a snapshot
//      dynamic data = ds.data['inspirationQuotes'];
//
//      var decode = jsonDecode(data);
//      // return decode.body;
//
//    });
  }

  /*Firestore.instance.collection('quote_topics').where("uid",isEqualTo: widget.topicName).limit(2).getDocuments().then((snapshot) {
       snapshot.documents.forEach((snap) {
         print(snap.data);
         print("Called");

       });
     });   */


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("pkl"),),
        body: Container(child:

        FutureBuilder(
            future: getQuotesByTopicName(),
            builder: (_,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: SpinKitDoubleBounce(
                  color: Colors.black,
                  size: 50.0,
                ),);

              }else {
               // print(snapshot.data);
                return Swiper(
                  layout: SwiperLayout.STACK,
                  itemHeight: 500,
                  itemWidth: 400,
                  itemCount: snapshot.data['Quotes'].length,
                  itemBuilder: (_,index){
                    print("----------------");
                    print(snapshot.data['Quotes'][index]["quote_text"]);
                    print("----------------");

              return Center(
                      child: Card(
                        elevation: 5.0,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          height: 500,
                          width: 400,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(

                                  children: <Widget>[
                                    Text('s',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
                                    Text('d',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),


                                  ],
                                ),
                              ),
                              Container(

                                padding: const EdgeInsets.all(15.0),
                                child:   Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ButtonIcon(iconUrl: 'assets/images/shareIcon.png'
                                      ,onPress: () async {

                                      },),
                                    ButtonIcon(iconUrl: 'assets/images/heartIcon.png'
                                      ,onPress: (){

                                      },),

                                  ],),
                              )
                            ],
                          ),
                        ),
                      ),
                    );





                    /* return ListTile(
                              title: Text(snapshot.data[index].data['topicName']),
                            ); */
                  },);
              }

            }
        )


        /* new Swiper(

          itemBuilder: (BuildContext context, int index) {
            return new Card(child: Container(
              color: _random,
              child: Center(
                child: Column(children: <Widget>[
                  Text('quoteText'),
                  Text('quoteAuthor'),

                ],),
              ),
            ),);
          },
          itemCount: 1,
          itemWidth: 300,
          itemHeight: 500,
          layout: SwiperLayout.STACK,
        )   */
        ));
  }


}