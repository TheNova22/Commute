import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key key, this.title, this.onTap, this.leading})
      : super(key: key);
  final void Function() onTap;
  final String title;
  final Widget leading;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      alignment: Alignment.centerLeft,
      width: width,
      decoration: BoxDecoration(
          color: Color(0xfff2f2f2),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFf0f0f0).withOpacity(0.5),
              offset: Offset(-3.0, -3.0),
              blurRadius: 3.0,
            ),
            BoxShadow(
              color: Color(0xFF4d4d4d).withOpacity(0.1),
              offset: Offset(3.0, 3.0),
              blurRadius: 3.0,
            ),
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
                leading,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
