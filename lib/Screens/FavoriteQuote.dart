
import 'package:besuccessful/Screens/QODScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoriteQuote extends StatefulWidget {

  static final id = 'favorite-quotes';


  @override
  _FavoriteQuoteState createState() => _FavoriteQuoteState();
}

class _FavoriteQuoteState extends State<FavoriteQuote> {

  void initState(){
    super.initState();
    _Read();
  }
   List<String> myStringList;

   _Read() async {
    final prefs = await SharedPreferences.getInstance();

    myStringList = prefs.getStringList('my_quotes_list_key') ?? [];
      setState(() {
        myStringList.toString();
      });
  }

  @override
  Widget build(BuildContext context) {

    var data = _Read();


    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(body:
          ListView.builder(
          padding: const EdgeInsets.all(8),
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, QODScreen.id);
        },
        child: Container(
        height: 50,
        child: Center(child: Text('$myStringList')),
        ),
      );
      }
      ),
      ),
    );
  }
}
