import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {

  ButtonIcon({this.iconUrl,this.onPress});

  Function onPress;
  String iconUrl;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 20,
      minWidth: 20,
      onPressed: onPress,
      child: Container(
        height: 20,
        width: 20,
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
