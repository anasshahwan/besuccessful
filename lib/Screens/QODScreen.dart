import 'dart:async';
import 'dart:convert';

import 'package:besuccessful/Screens/DisplayQoutes.dart';
import 'package:besuccessful/Screens/FamousPersonQuotes.dart';
import 'package:besuccessful/Screens/FavoriteQuote.dart';
import 'package:besuccessful/Screens/LoadingScreen.dart';
import 'package:besuccessful/Screens/QouteCategories.dart';
import 'package:besuccessful/Screens/QuoteTopics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'QODScreen.dart';
import 'package:http/http.dart';
//import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/networking.dart';
import '../CustomWidgets/ButtonIcon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../CustomWidgets/QuoteCard.dart';

import 'package:cached_network_image/cached_network_image.dart';
import '../Services/QuoteBrain.dart';

const String testDevice =
    'c1vl7fiXbq4:APA91bEnlRMu7oO3Uh1CmntGqmti17NlvdUR3HK3L6kwLMVHg5SrkeU3-BWcA2POleAiv61lBJTwdlBvtp-6PJCFN-JfaH4_BaQQLpqB9GHbqp7WRcoA8NNEcgAxjrjui8-qMyz7LVYb';

QuoteBrain quoteBrain = QuoteBrain();

class QODScreen extends StatefulWidget {
  static final id = 'QOD-screen';
  @override
  _QODScreenState createState() => _QODScreenState();
}

class _QODScreenState extends State<QODScreen> {
  // Add Mob

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Motivation', 'inspiration'],
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: 'ca-app-pub-3275534231839381/8052108006',
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("Object  Banner Ad : $event");
        });
  }

  // add Mob End

  String quoteText, quoteAuthor, quoteTitle, quoteImage;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseCloudMessaging_Listeners();
    _scrollController.addListener((){

      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
           //  getMoreFamousPeopleNames();
      }

    });

    /*FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-3275534231839381~3938082109');
    _bannerAd = createBannerAd()
      ..load()
      ..show(); */
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

    _firebaseMessaging.getToken().then((token) {
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
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
  ////////////////
  List<DocumentSnapshot> _quotes = [];
  bool isLoading = true;
  int per_page = 5;
  DocumentSnapshot _lastDocument;
  bool _gettingMoreQuotes = false;
  bool _moreQuotesAvailable = true;

  Future getFamousPeopleNames() async {
    var firestore = Firestore.instance;
    Query q = await firestore.collection('famous-people').limit(per_page);

    isLoading = true;

    QuerySnapshot querySnapshot = await q.getDocuments();
    _quotes = querySnapshot.documents;
    _lastDocument = querySnapshot.documents[querySnapshot.documents.length -1 ];


  }
  Future getMoreFamousPeopleNames() async {

    var firestore = Firestore.instance;
    Query q = await firestore.collection('famous-people').orderBy('name').startAfter([_lastDocument.data['name']]).limit(per_page);
    QuerySnapshot querySnapshot = await q.getDocuments();
     // _quotes.

    _lastDocument = querySnapshot.documents[querySnapshot.documents.length -1 ];
    print(_quotes);
    print('called');



  }

  Future getQuotesCategories() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('categories').getDocuments();
    return qn.documents;

  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text(
              'Be Inspired',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xFF8BA8DC),
            elevation: 0.0,
            centerTitle: true,
            actions: [
              Icon(
                Icons.perm_identity,
                size: 30.0,
              ),
              ButtonIcon(
                iconUrl: 'assets/images/planet-earth.png',
                onPress: () {
                  print("list");

                  var quotee = quoteBrain.getQOD();
                  print("---------------");
                  //   Navigator.pushNamed(context, FavoriteQuote.id);
                },
              ),
            ],
            leading: ButtonIcon(
              iconUrl: 'assets/images/menu.png',
              onPress: () {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) =>
                        QuoteTopics()));
              },
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              child: Container(
            height: 70,
            color: Color(0xFF8BA8DC),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        size: 30.0,
                      ),
                      Text('Add Your Own Quote')
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        size: 30.0,
                      ),
                      Text('Search')
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.favorite_border,
                        size: 30.0,
                      ),
                      Text('My Favorite')
                    ],
                  ),
                ],
              ),
            ),
          )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new QuoteCard(
                    cardTitle: 'Quote Of The Day ',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Explore More ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Famous People Said  ",
                        style: TextStyle(
                          color: Color(0xFF717171),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                  SizedBox(
                    height: 250.0,
                    child: FutureBuilder(
                         future: getFamousPeopleNames(),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: SpinKitDoubleBounce(
                                color: Colors.black,
                                size: 50.0,
                              ),
                            );
                          } else {

                            return ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: _quotes.length,
                              itemBuilder: (_, index) {
                           if(index<_quotes.length-1) {
                             return GestureDetector(
                               onTap: () {
                                 Navigator.push(context,
                                     MaterialPageRoute(builder: (context) {
                                       return LoadingScreen(
                                           photo_url: _quotes[index]
                                               .data['photo_url'],
                                           famousName: _quotes[index]
                                               .data['name']);
                                     }));
                               },
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Card(
                                   child: Container(
                                     height: 250,
                                     width: 250,
                                     child: Stack(
                                       children: <Widget>[
                                         CachedNetworkImage(
                                           imageUrl: _quotes[index]
                                               .data['photo_url'],
                                           fit: BoxFit.fill,
                                           width: 250,
                                           height: 250,
                                           placeholder: (context, url) =>
                                               CircularProgressIndicator(),
                                           errorWidget:
                                               (context, url, error) =>
                                               Icon(Icons.error),
                                         ),
                                         Container(
                                             decoration: new BoxDecoration(
                                                 color: new Color.fromRGBO(
                                                     100, 100, 100,
                                                     0.5) // Specifies the background color and the opacity
                                             ),
                                             child: Center(
                                                 child: Text(
                                                   _quotes[index].data['name'],
                                                   style: TextStyle(
                                                       fontSize: 20,
                                                       fontWeight: FontWeight
                                                           .bold,
                                                       color: Colors.black),
                                                 )))
                                       ],
                                     ),
                                   ),
                                 ),
                               ),
                             );
                           }else {
                             return GestureDetector(
                                 onTap: getMoreFamousPeopleNames,
                                 child: Text('ADd More '));
                           }
                                /* return ListTile(
                                title: Text(snapshot.data[index].data['topicName']),
                              ); */
                              },
                            );
                          }
                        }),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Categories  ",
                        style: TextStyle(
                          color: Color(0xFF717171),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                  SizedBox(
                    height: 300,
                    child: FutureBuilder(
                        future: getQuotesCategories(),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: SpinKitDoubleBounce(
                                color: Colors.black,
                                size: 50.0,
                              ),
                            );
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return DisplayQoutes(
                                        topicName: snapshot
                                            .data[index].data['topicName'],
                                      );
                                    }));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 250,
                                      width: 250,
                                      child: Container(
                                        height: 200,
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: const Color(0xff717171),
                                          image: DecorationImage(
                                            colorFilter: new ColorFilter.mode(
                                                Colors.black.withOpacity(0.2),
                                                BlendMode.dstATop),
                                            image: NetworkImage(''),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          snapshot
                                              .data[index].data["topicName"],
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                );

                                /* return ListTile(
                                title: Text(snapshot.data[index].data['topicName']),
                              ); */
                              },
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
