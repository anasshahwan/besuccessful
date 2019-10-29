import 'dart:async';
import 'dart:convert';

import 'package:besuccessful/Screens/DisplayQoutes.dart';
import 'package:besuccessful/Screens/FavoriteQuote.dart';
import 'package:besuccessful/Screens/QouteCategories.dart';
import 'package:besuccessful/Screens/QuoteTopics.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'QODScreen.dart';
import 'package:http/http.dart';
//import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/networking.dart';
import '../CustomWidgets/ButtonIcon.dart';

import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_admob/firebase_admob.dart';


const String testDevice =  'c1vl7fiXbq4:APA91bEnlRMu7oO3Uh1CmntGqmti17NlvdUR3HK3L6kwLMVHg5SrkeU3-BWcA2POleAiv61lBJTwdlBvtp-6PJCFN-JfaH4_BaQQLpqB9GHbqp7WRcoA8NNEcgAxjrjui8-qMyz7LVYb';

class QODScreen extends StatefulWidget {
  QODScreen({this.quoteData});
  final quoteData;
  static final id = 'QOD-screen';
  @override
  _QODScreenState createState() => _QODScreenState();
}

class _QODScreenState extends State<QODScreen> {

  // Add Mob

 static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
   testDevices: testDevice != null ? <String>[testDevice] : null,
   nonPersonalizedAds: true,
   keywords: <String>['Motivation','inspiration'],

 );

 BannerAd _bannerAd;

 BannerAd createBannerAd(){
   return BannerAd(
     adUnitId: 'ca-app-pub-3275534231839381/8052108006',
     size: AdSize.banner,
     targetingInfo: targetingInfo,
     listener: (MobileAdEvent event){
       print("Object  Banner Ad : $event");
     }

   );
 }

  // add Mob End

  String quoteText,quoteAuthor,quoteTitle,quoteImage;


  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getQOD(widget.quoteData);
    firebaseCloudMessaging_Listeners();

    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-3275534231839381~3938082109');
    _bannerAd = createBannerAd()..load()..show();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd.dispose();
    super.dispose();
  }


  /* notification */

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token){
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }
  ////////////////

  void _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_quotes_list_key';

    List myArray = [];

    final oldValue = prefs.getStringList('my_quotes_list_key') ?? [];

    myArray = oldValue;
    print("myArray");
    print(myArray);

    final newValue = quoteText;
    print("AFter ADdd yArray");

    myArray.add(newValue);
print(myArray);

    prefs.setStringList('$key',myArray);
    print('saved $newValue');

  }


  void getQOD(dynamic quoteData) async {

        quoteText = quoteData["contents"]["quotes"][0]["quote"];
        quoteTitle = quoteData["contents"]["quotes"][0]["title"];
        quoteAuthor = quoteData["contents"]["quotes"][0]["author"];
        quoteImage = quoteData["contents"]["quotes"][0]["background"];
  }






  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(

            backgroundColor: Colors.transparent,
            key: _scaffoldKey,
            appBar: AppBar(
              title: const Text('Qoute Of The Day',style: TextStyle(color: Colors.black),),
              backgroundColor: Color(0xFFFFFFFF),
elevation: 0.0,
centerTitle: true,

              actions: [
                ButtonIcon(iconUrl: 'assets/images/notificationIcon.png'
                  ,onPress: (){
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) =>
                            DisplayQoutes()));
                    print("notificaation");
                  },),
                ButtonIcon(iconUrl: 'assets/images/favoritelistIcon.png'
                  ,onPress: (){
                    print("list");
                    Navigator.pushNamed(context, FavoriteQuote.id);
                  },),
              ], leading:  ButtonIcon(iconUrl: 'assets/images/menuIcon.png'
              ,onPress: (){
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) =>
                        QuoteTopics()));

               },),
            ),


          body: Column(
            children: <Widget>[
                Expanded(child: Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(
                    "$quoteText",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'OpenSans',fontSize: 25,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text(
                      "--$quoteAuthor",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'OpenSans',fontSize: 15,fontWeight: FontWeight.bold),),



                  ],
                ))),
Container(

  padding: const EdgeInsets.all(15.0),
  child:   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
         ButtonIcon(iconUrl: 'assets/images/shareIcon.png'
           ,onPress: () async {
             final prefs = await SharedPreferences.getInstance();
             prefs.remove('my_quotes_list_key');

             Share.share("Share Some Text");
         },),
         ButtonIcon(iconUrl: 'assets/images/heartIcon.png'
          ,onPress: _save,),

    ],),
)

            ],
          )
        ),
      ),
    );
  }
}

