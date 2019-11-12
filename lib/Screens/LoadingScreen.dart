import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:besuccessful/Screens/QODScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Services/networking.dart';
import 'FamousPersonQuotes.dart';
class LoadingScreen extends StatefulWidget {

  static final id = "loading-screen";

  LoadingScreen({this.photo_url,this.famousName});

  final photo_url,famousName;


  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  // getQouteData();

    //print(widget.data);
//    quote = quoteData["contents"]["quotes"][0]["quote"];
//    title = quoteData["contents"]["quotes"][0]["title"];
//    author = quoteData["contents"]["quotes"][0]["author"];
//

  }

  void getQouteData() async{
  //  NetworkHelper networkHelper = NetworkHelper("http://quotes.rest/qod.json");
   // var quoteData = await networkHelper.getQODData();

  }
  Future getQuotesByFamousName() async{
//
//       var  qn =  await Firestore.instance.collection('quote_famous_people').document('Bill Gates').get();
//      return qn;

//    QuerySnapshot qn = await Firestore.instance.collection('quote_famous_people').where("name", isEqualTo: widget.famousName).getDocuments();
//    return qn.documents;

    var  qn =  await Firestore.instance.collection('quote_famous_people').document(widget.famousName).get();
    return qn;
  }

  @override
  Widget build(BuildContext context) {
   return  FutureBuilder(
        future: getQuotesByFamousName(),
        builder: (_,snapshot){
          if(!snapshot.hasData) {
            print("dosnet Have");
            return new Container(
              child: Center(child: new CircularProgressIndicator()),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done) {


                  return FamousPersonQuotes(
                      famousName: widget.famousName,photo_url: widget.photo_url,data: snapshot.data['quotes'],);


//            return ListView.builder(
//              shrinkWrap: true,
//
//              itemCount: snapshot.data['quotes'].length,
//              itemBuilder: (_,index){
//                //      print(snapshot.data[0].length);
//                //print(snapshot.data[index].data['quotes'][2]);
//
//                return Container(
//                    height: 300,
//                    width: 300,
//                    child: Card(child: Text(snapshot.data['quotes'][index]['quote_text']),));
//
//                /* return ListTile(
//                              title: Text(snapshot.data[index].data['topicName']),
//                            ); */
//              },);

          }

        }
    );

  }
}
