import 'package:flutter/material.dart';

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20, bottom: 5),
      alignment: Alignment.centerLeft,
      width: width,
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w500),
      ),
    );
  }
}
