import 'package:besuccessful/Screens/DisplayQoutes.dart';
import 'package:flutter/material.dart';
import 'DisplayQoutes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class QuoteTopics extends StatefulWidget {
  @override
  _QuoteTopicsState createState() => _QuoteTopicsState();
}

class _QuoteTopicsState extends State<QuoteTopics> {
  @override
  void initState() {
    super.initState();
    getQuoteTopics();

    _scrollController.addListener((){

      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        getMoreQuoteTopics();
      }

    });
  }


  List<DocumentSnapshot> myData = [];
  DocumentSnapshot _lastDocument;
  bool _loadingQuotes = true;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreQuotes = false;
  bool _moreQuotesAvailable = true;

  int per_page = 5;


  getQuoteTopics() async {
    var firestore = Firestore.instance;
    Query query = await firestore.collection('categories').limit(per_page);
    //getDocuments();
    setState(() {
      _loadingQuotes = true;

    });
    QuerySnapshot querySnapshot = await query.getDocuments();
    myData = querySnapshot.documents;
    _lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1 ];
    setState(() {
      _loadingQuotes = false;

    });
    print("End Get Quote Topics ..");
 //   print(_lastDocument.documentID);
  } // make list widget ..

  Future getMoreQuoteTopics() async {

    if(_moreQuotesAvailable == false){
      print("No More .. ");
      return;
    }
    if(_gettingMoreQuotes== true){
      return;
    }

    _gettingMoreQuotes = true;
    var firestore = Firestore.instance;
    Query query = await firestore.collection('categories').where("random_key", isGreaterThan: 4).orderBy('random_key').limit(5);
    QuerySnapshot querySnapshot = await query.getDocuments();
    myData.addAll(querySnapshot.documents);

    if(querySnapshot.documents.length < per_page) {
      _moreQuotesAvailable = false;

    }
    _lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1 ];

    setState(() {});
    _gettingMoreQuotes = false;

    print("Get More Products ... ");
   // print (_lastDocument.documentID);
  //  print(querySnapshot.documents.toString());

    List<DocumentSnapshot> newList = querySnapshot.documents;


    print("NEwwwwwwwwww List ");

        print(newList.length);
        for(var i in newList) {
          print(i.data['topicName']);
        }

    print("End The Listttt NEwwwwwwwwww List ");


//    }).toList();
  } // make list widget ..

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("ok"),),
        backgroundColor: Colors.white.withOpacity(
            0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
        body: _loadingQuotes == true ? Container(
          child: Center(child: Text("Loading .."),),
        ) : Container(
          child: myData.length == 0
              ? Center(child: Text("There is No Quotes  .."))
              : ListView.builder(
            controller: _scrollController,
              itemCount: myData.length,
              itemBuilder:(_,index){
           //   print(index);
            //    print(myData[index].data['topicName']);
              //  print('Last Docuemnts is ' + _lastDocument.data['topicName']);
                 return Container(
                   height: 400,
                   width: 400,
                   child: Card(
                     child: Text(myData[index].data['topicName']),
                   ),
                 );
              }


          ),
        ),
      ),
    );
  }
}

//
//Expanded(
//child: FutureBuilder(
//future: getQuoteTopics(),
//builder: (_, snapshot) {
//if (snapshot.connectionState == ConnectionState.waiting) {
//return Center(
//child: SpinKitDoubleBounce(
//color: Colors.black,
//size: 50.0,
//),
//);
//} else {
//return ListView.builder(
//itemCount: snapshot.data.length,
//itemBuilder: (_, index) {
//return Center(
//child: GestureDetector(
//onTap: () {
//Navigator.push(context,
//MaterialPageRoute(builder: (context) {
//return DisplayQoutes(
//topicName: snapshot.data[index].data['topicName'],
//);
//}));
//},
//child: Card(
//elevation: 5.0,
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadius.circular(10.0),
//),
//child: Container(
//height: 200,
//margin: EdgeInsets.all(10),
//decoration: BoxDecoration(
//color: const Color(0xff7c94b6),
//image: DecorationImage(
//colorFilter: new ColorFilter.mode(
//Colors.black.withOpacity(0.2),
//BlendMode.dstATop),
//image: AssetImage(
//"assets/images/test1.jpg"),
//fit: BoxFit.cover,
//),
//),
//child: Center(
//child: Text(
//snapshot.data[index].data['topicName'],
//style: TextStyle(
//fontSize: 25,
//fontWeight: FontWeight.bold,
//color: Colors.white),
//)),
//),
//),
//),
//);
//
///* return ListTile(
//                              title: Text(snapshot.data[index].data['topicName']),
//                            ); */
//},
//);
//}
//}),
//),

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
