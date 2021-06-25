import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:cantin/QR_Scanner/qrScanner.dart';
import 'package:cantin/Vaccines_Near_Me_Page/VaccinesNearMePage.dart';
import 'package:cantin/country.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../globals.dart';
import 'widgets/FlexibleContent.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum PlayerState { stopped, playing, paused }

class _HomePageState extends State<HomePage> {
  bool isOwner = false;
  static AudioCache player = new AudioCache();
  String realCode;
  Future<String> getCountryName() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    debugPrint('location: ${position.latitude}');
    updateGlobalLocation(position.latitude, position.longitude);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return first.countryName; // this will return country name
  }

  void allFuncs() async {
    await getDeets().then((value) {
      var arr = value.keys;
      Map<String, Country> countryCodes = {};
      for (int i = 0; i < arr.length; i++) {
        Country x = Country(
          location: value[arr.elementAt(i)].location,
          totalVaccinations: value[arr.elementAt(i)].totalVaccinations,
          code: arr.elementAt(i),
        );
        countryCodes[value[arr.elementAt(i)].location.toLowerCase()] = x;
      }
      countryData = countryCodes;
    }).then((value) {
      getCountryName().then((value) {
        country = value;
        code = countryData[country.toLowerCase()].code;
        realCode = code;
        if (code.length > 2) {
          code = code[0] + code[1];
        }
        setState(() {});
      });
    });
  }

  void ownerCheck() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection("users")
        .doc(userIdGlobal)
        .get();
    final docData = data.data();
    isOwner = docData["isOwner"];
  }

  @override
  void initState() {
    allFuncs();
    ownerCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    int _counter = 0;
    Color isVaccinatedColor = Color(0xFFDAF7A1);
    void _changeColor(bool isVaccinated) {
      isVaccinatedColor = isVaccinated ? Color(0xFFDAF7A1) : Color(0xFFF7B8A1);
    }

    double w = MediaQuery.of(context).size.width;
    String flag = code.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0).codeUnitAt(0) + 127397));

    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBox) {
            return <Widget>[
              SliverAppBar(
                elevation: 5,
                titleSpacing: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(120),
                        bottomRight: Radius.circular(0))),
                backgroundColor: isVaccinatedColor,
                titleTextStyle: TextStyle(color: Colors.black26),
                expandedHeight: h / 3,
                forceElevated: true,
                pinned: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.local_hospital,
                        color: Colors.black87,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(VaccineDriveNearMe.routeName);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.black87,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/settingsPage');
                      },
                    ),
                  ],
                ),
                flexibleSpace: Container(
                  // margin: EdgeInsets.only(top: h / 8),
                  child: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FlexibleContents(
                        realCode: realCode,
                        flag: flag,
                        changeColor: _changeColor,
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          //
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "QR Code",
                        style: TextStyle(fontSize: 28),
                      ),
                      if (isOwner)
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.qr_code_scanner,
                                color: Colors.black87,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, QRScanner.routeName);
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.table_chart,
                                color: Colors.black87,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/logPage');
                              },
                            ),
                          ],
                        )
                    ],
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      _counter++;
                      if (_counter % 7 == 0) {
                        player.play("Ohayo.mp3");
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFf2f2f2),
                          gradient: RadialGradient(
                            colors: [
                              Colors.black.withOpacity(0.0),
                              Colors.black.withOpacity(0.2),
                            ],
                            center: AlignmentDirectional(0.0, 0.0),
                            focal: AlignmentDirectional(0.0, 0.0),
                            radius: 0.619,
                            focalRadius: 0.001,
                            stops: [0.75, 1.0],
                          ),
                        ),
                        child: Center(
                            child: QrImage(
                          data: userIdGlobal,
                          size: 175,
                        ))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Statistics ",
                        style: TextStyle(fontSize: 28),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/statPage');
                        },
                        child: Text("View More"),
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                    future: Future.delayed(Duration(seconds: 5), () {
                      return 5;
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(child: CountryList());
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })
              ],
            ),
          )),
    );
  }
}

class CountryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    List<String> keys =
        (countryData.length > 0) ? countryData.keys.toList() : ["india"];
    keys.shuffle();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: (countryData.length > 0) ? 10 : 1,
        itemBuilder: (context, index) {
          String flag = "🚩";
          if (countryData[keys[index]].code != null) {
            if (countryData[keys[index]].code.length > 2) {
              flag = (countryData[keys[index]].code[0] +
                      countryData[keys[index]].code[1])
                  .toUpperCase()
                  .replaceAllMapped(
                      RegExp(r'[A-Z]'),
                      (match) => String.fromCharCode(
                          match.group(0).codeUnitAt(0) + 127397));
            } else {
              flag = (countryData[keys[index]].code)
                  .toUpperCase()
                  .replaceAllMapped(
                      RegExp(r'[A-Z]'),
                      (match) => String.fromCharCode(
                          match.group(0).codeUnitAt(0) + 127397));
            }
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: w / 3.4,
                      child: (countryData[keys[index]].code != null)
                          ? Text(
                              countryData[keys[index]].code.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            )
                          : Text("IN"),
                    ),
                    Container(
                      width: w / 3.4,
                      alignment: Alignment.center,
                      child: Text(flag, style: TextStyle(fontSize: 16)),
                    ),
                    Container(
                      width: w / 3.4,
                      alignment: Alignment.center,
                      child: (countryData[keys[index]].totalVaccinations ==
                              null)
                          ? Text("0")
                          : Text(countryData[keys[index]]
                              .totalVaccinations
                              ?.toInt()
                              .toString()
                              .replaceAllMapped(
                                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},')),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
