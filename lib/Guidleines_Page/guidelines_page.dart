import 'package:flutter/material.dart';

class GuidelinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Color(0xfff2f2f2),
        title: Text(
          "Guidelines",
          style: TextStyle(fontSize: 24, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InfoContainer(
                  info: "Always carry essentials required during this pandemic",
                  path: "assets/equip.jpg",
                  left: true,
                  fSize: 26,
                  textColor: Colors.grey[50],
                  containerColor: Color(0xFF7D9DAE),
                  w1: w / 2,
                  w2: w / 3),
              SizedBox(
                height: 20,
              ),
              InfoContainer(
                  info:
                      "Make sure to follow the rules mentioned by the places you will visit",
                  path: "assets/friends.jpg",
                  left: false,
                  textColor: Colors.grey[900],
                  containerColor: Color(0xFFF9EFEA),
                  fSize: 24,
                  w1: w / 2,
                  w2: w / 3),
              SizedBox(
                height: 20,
              ),
              InfoContainer(
                  info:
                      "Family's safety should also be taken care of. Visit places only when needed",
                  path: "assets/family.jpg",
                  left: true,
                  textColor: Colors.grey[800],
                  containerColor: Color(0xFFCFE4FC),
                  fSize: 23,
                  w1: w / 2,
                  w2: w / 3),
              SizedBox(
                height: 20,
              ),
              InfoContainer(
                  info:
                      "Remember to always maintain social distancing and avoid close contact",
                  path: "assets/social-distancing.png",
                  left: false,
                  textColor: Colors.grey[850],
                  containerColor: Color(0xFFD6E0F2),
                  fSize: 23,
                  w1: w / 2,
                  w2: w / 3),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer(
      {Key key,
      this.info,
      this.path,
      this.left,
      this.textColor,
      this.containerColor,
      this.w1,
      this.w2,
      this.fSize})
      : super(key: key);
  final String info, path;
  final bool left;
  final Color textColor, containerColor;
  final double w1, w2, fSize;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: left ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          width: w / 1.12,
          height: 200,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: left
                ? BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50))
                : BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
          ),
          child: Row(
            children: left
                ? [
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 5),
                      width: w1,
                      child: Text(
                        info,
                        style: TextStyle(
                            color: textColor,
                            fontSize: fSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Image.asset(
                      path,
                      width: w2,
                      fit: BoxFit.fitWidth,
                    )
                  ]
                : [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Image.asset(
                        path,
                        width: w2,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 5),
                      width: w1,
                      child: Text(
                        info,
                        textDirection:
                            left ? TextDirection.ltr : TextDirection.rtl,
                        style: TextStyle(
                            color: textColor,
                            fontSize: fSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
          ),
        ),
      ],
    );
  }
}
