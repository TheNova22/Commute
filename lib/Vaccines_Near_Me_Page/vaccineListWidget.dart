import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../globals.dart';

class VaccineListWidget extends StatefulWidget {
  final bool isAdmin;
  final QueryDocumentSnapshot documentSnapshot;
  VaccineListWidget({Key key, this.documentSnapshot, this.isAdmin})
      : super(key: key);

  @override
  _VaccineListWidgetState createState() => _VaccineListWidgetState();
}

class _VaccineListWidgetState extends State<VaccineListWidget> {
  _callNumber() async {
    const number = '08592119XXXX'; //set the number here
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    double lat = widget.documentSnapshot["latitude"],
        long = widget.documentSnapshot["longitude"];
    if (lat == null || long == null) {
      lat = 12.91968822479248;
      long = 77.51994323730469;
    }
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      height: height / 3,
      width: width - 10,
      decoration: BoxDecoration(
          color: (widget.documentSnapshot["price"].toInt() < 500)
              ? Color(0xFFE0ECFF).withOpacity(1)
              : Color(0xFFE0FFE5),
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.5),
                offset: Offset(-1, -1),
                blurRadius: 1),
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(1, 1),
                blurRadius: 1)
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: Text(
                widget.documentSnapshot["name"].toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Color(0xf0f0f0f0),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 1,
                              offset: Offset(-1, -1)),
                          BoxShadow(
                              color: Colors.black54.withOpacity(0.1),
                              blurRadius: 1,
                              offset: Offset(1, 1)),
                        ]),
                    child: IconButton(
                      splashRadius: 20,
                      icon: Icon(
                        Icons.public,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Color(0xf0f0f0f0),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 1,
                              offset: Offset(-1, -1)),
                          BoxShadow(
                              color: Colors.black54.withOpacity(0.1),
                              blurRadius: 1,
                              offset: Offset(1, 1)),
                        ]),
                    child: IconButton(
                      splashRadius: 20,
                      icon: Icon(
                        Icons.call,
                        size: 20,
                      ),
                      onPressed: () {
                        showAlertDialog(BuildContext context) {
                          // set up the buttons
                          Widget cancelButton = FlatButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          );
                          Widget continueButton = FlatButton(
                            child: Text("Call"),
                            onPressed: () {
                              _callNumber();
                            },
                          );

                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Text("Call Confirmation"),
                            content: Text("Do you want to call?"),
                            actions: [
                              cancelButton,
                              continueButton,
                            ],
                          );

                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }

                        showAlertDialog(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                MapsLauncher.launchQuery(widget.documentSnapshot['address']);
              },
              child: Container(
                height: (height ~/ 4).toDouble(),
                width: ((width / 1.3) ~/ 1).toDouble(),
                margin: EdgeInsets.only(bottom: 10, right: 10),
                decoration: BoxDecoration(
                  // color: Colors.pink,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                    generateLocationPreviewImage(
                        height: height,
                        width: width,
                        latitude: lat,
                        longitude: long),
                  )),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 10, right: 10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                            "₹ " + widget.documentSnapshot["price"].toString(),
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
