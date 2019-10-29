import 'dart:async';

import 'package:besuccessful/Screens/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'QODScreen.dart';

class SplashScreen extends StatefulWidget {
  static final id = 'splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Timer(Duration(seconds: 5), () => Navigator.pushNamed(context, MyHomePage.id));
  }

  @override
  Widget build(BuildContext context) {
       return WillPopScope(
         onWillPop: () async => false,
         child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.grey),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Be Successful ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                          SizedBox(height: 10,),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50.0,

                              child: Container(
                                height: 150,
                                width: 400,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(10),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/logoS.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    // ...
                                  ),
                                ),
                              )
                          ),

              RaisedButton(onPressed: (){
                Navigator.pushNamed(context, LoadingScreen.id);

              },child: Text("QOD Page "),)


                        ],
                      ),
                    ),
                  ),

                ],
              )
            ],
          ),
    ),
       );
  }
}