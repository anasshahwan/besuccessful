import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../CustomWidgets/ButtonIcon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';


class FamousPersonQuotes extends StatefulWidget {

  FamousPersonQuotes({this.photo_url,this.famousName,this.data});

  final photo_url,famousName,data;

  static final id = "famous-person-screen";
  @override
  _FamousPersonQuotesState createState() => _FamousPersonQuotesState();
}

class _FamousPersonQuotesState extends State<FamousPersonQuotes> {

  String photo_url,famousName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      updateTheUI();
    print('-------');

      print(widget.data.length);
    print('-----');

  }


  void updateTheUI(){
    photo_url = widget.photo_url;
    famousName = widget.famousName;
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
    return Scaffold(

      body: CustomScrollView(

          slivers: <Widget>[
        SliverAppBar(
          pinned: true,
            backgroundColor: Colors.white,
          title: Text(widget.famousName,style: TextStyle(color: Colors.black),),
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: widget.photo_url,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),

    ),
       ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context,index){
          if(index<widget.data.length)
            return Container(
              height: 400,
                child: Column(children: <Widget>[

                  Expanded(
                    child: Row(children: <Widget>[

                      Text('“'),

    Expanded(child:                       Text(widget.data[index]['quote_text']),
        ),
                      Text('”'),

                    ],),
                  ),
                  Expanded(
                    child: Row(children: <Widget>[

                      Container(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ButtonIcon(
                              iconUrl: 'assets/images/shape.png',
                              onPress: () async {
                                final prefs =
                                await SharedPreferences.getInstance();
                                prefs.remove('my_quotes_list_key');

                              },
                            ),
                            ButtonIcon(
                              iconUrl: 'assets/images/heart.png',
                              onPress: (){},
                            ),
                          ],
                        ),
                      )

                    ],),
                  )
            ],)
            );

        }
          ),
        )
      ]),
    );
  }
}
