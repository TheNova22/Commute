import 'package:cantin/country.dart';
import 'package:cantin/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FlexibleContents extends StatelessWidget {
  final void Function(bool isVaccinated) changeColor;
  const FlexibleContents({
    Key key,
    @required this.realCode,
    @required this.flag,
    @required this.changeColor,
  }) : super(key: key);

  final String realCode;
  final String flag;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        getDeets(),
        FirebaseFirestore.instance.collection('users').doc(userIdGlobal).get(),
        Future.delayed(Duration(seconds: 5)),
      ]),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          changeUserIsVaccinatedValue(snapshot.data[1]['vaccinated']);
          changeColor(globalUserIsVaccinated);
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                (snapshot.data[0][realCode].totalVaccinations?.toInt() ?? 0.0)
                    .toString()
                    .replaceAllMapped(
                        new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},'),
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              Text(
                "People have been vaccinated",
                textDirection: TextDirection.rtl,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, bottom: 8),
                child: Container(
                  width: MediaQuery.of(ctx).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            child: Image.asset(
                              "assets/mask.png",
                              height: 50,
                              fit: BoxFit.fitHeight,
                            ),
                            radius: 30,
                            backgroundColor: Colors.transparent,
                          ),
                          Text(
                            snapshot.data[1]['userName'],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            child: Icon(
                              Icons.masks_outlined,
                              color: Colors.black,
                              size: 40,
                            ),
                            alignment: Alignment.center,
                            height: 60,
                          ),
                          Text(
                            snapshot.data[1]['vaccinated']
                                ? snapshot.data[1]
                                    ['name_of_vaccine_if_vaccinated']
                                : "Not Vaccinated",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            child: Text(
                              flag,
                              style: TextStyle(fontSize: 30),
                            ),
                            alignment: Alignment.center,
                            height: 60,
                          ),
                          Text(
                            country.toUpperCase(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
