import 'dart:async';

import 'package:besuccessful/Screens/QODScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Services/networking.dart';
class LoadingScreen extends StatefulWidget {

  static final id = "loading-screen";

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQouteData();

//    quote = quoteData["contents"]["quotes"][0]["quote"];
//    title = quoteData["contents"]["quotes"][0]["title"];
//    author = quoteData["contents"]["quotes"][0]["author"];
//

  }

  void getQouteData() async{
    NetworkHelper networkHelper = NetworkHelper("http://quotes.rest/qod.json");
    var quoteData = await networkHelper.getQODData();
    Navigator.push(context,MaterialPageRoute(builder:(context){
      return QODScreen(quoteData: quoteData,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: SpinKitDoubleBounce(
        color: Colors.black,
        size: 50.0,
      )
    ),);
  }
}
