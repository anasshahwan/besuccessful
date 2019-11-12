import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {

  ButtonIcon({this.iconUrl,this.onPress});

  Function onPress;
  String iconUrl;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 25,
      minWidth: 25,
      onPressed: onPress,
      child: Container(
        height: 25,
        width: 25,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(iconUrl),
              fit: BoxFit.fill,
            ),
            // ...
          ),
        ),
      ),
    );
  }
}
