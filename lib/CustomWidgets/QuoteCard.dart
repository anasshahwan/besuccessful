import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ButtonIcon.dart';
import 'dart:core';
import '../Services/QuoteBrain.dart';

QuoteBrain quoteBrain = QuoteBrain();

DateTime now = new DateTime.now();
DateTime date = new DateTime(now.year, now.month, now.day);
String todayDate = date.month.toString() + " , " + date.day.toString() + " , " + date.year.toString();

class QuoteCard extends StatelessWidget {

  QuoteCard({this.cardTitle,this.cardBody,this.cardAuthor,cardDate});

   String cardTitle,cardBody,cardAuthor,cardDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: new Container(
            decoration: new BoxDecoration(
                borderRadius:
                new BorderRadius.all(Radius.circular(20.0))),
            child: Column(
              children: <Widget>[

                FutureBuilder(
                  future: quoteBrain.getQOD(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      return Column(
                        children: <Widget>[

                          Text(
                            "$cardTitle",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
    SizedBox(height: 20 ,),
                          Text(snapshot.data[0].data['quote_of_day']['quote_text'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF717171),
                                fontFamily: 'OpenSans',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "   --" + snapshot.data[0].data['quote_of_day']['quote_author'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text( todayDate,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
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
                        ],
                      );

                    }else {
                      return  CircularProgressIndicator();
                    }
                  },
                ),
             /*   */

              ],
            )),
      ),
    );
  }
}
