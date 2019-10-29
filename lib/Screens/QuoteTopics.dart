import 'package:besuccessful/Screens/DisplayQoutes.dart';
import 'package:flutter/material.dart';
import  'DisplayQoutes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class QuoteTopics extends StatefulWidget {


  @override
  _QuoteTopicsState createState() => _QuoteTopicsState();
}

class _QuoteTopicsState extends State<QuoteTopics> {
  static final List<String> _listViewData = [
    "Inducesmile.com",
    "Flutter Dev",
    "Android Dev",
    "iOS Dev!",
    "React Native Dev!",
    "React Dev!",
    "express Dev!",
    "Laravel Dev!",
    "Angular Dev!",
  ];

  List<Widget> makeListWidget(AsyncSnapshot snapshot){

    return snapshot.data.documents.map<Widget>((DocumentSnapshot document) {
      //print(document.data);
      return

        Center(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder:(context){
                return DisplayQoutes(topicName: document['topicName']);
              }));                                    },
            child: Card(
              elevation: 5.0,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 200,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    image: AssetImage("assets/images/test1.jpg"),
                    fit: BoxFit.cover,
                  ),),
                child: Center(child: Text(document['topicName'],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
              ),
            ),
          ),
        );


    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Text("Quote Topics ",style: TextStyle(color: Colors.black),),
              Expanded(
                child: StreamBuilder(
                   stream: Firestore.instance.collection('/categories').snapshots(),
                  builder: (context,snapshot){
                   switch(snapshot.connectionState){
                     case ConnectionState.waiting:
                       return Center(child: CircularProgressIndicator(),);

                     default:
                       return ListView(
    children: makeListWidget(snapshot),
    );
                       }

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


/*
*
*   .map((data) => Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context){
                          return DisplayQoutes();
                        }));                                    },
                      child: Card(
                        elevation: 5.0,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          height: 200,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: DecorationImage(
                              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                              image: AssetImage("assets/images/test1.jpg"),
                              fit: BoxFit.cover,
                            ),),
                          child: Center(child: Text(data,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
                        ),
                      ),
                    ),
                  ))
                      .toList(),
*   */