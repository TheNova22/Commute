import 'package:cantin/Vaccines_Near_Me_Page/vaccineListWidget.dart';
import 'package:cantin/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VaccineDriveNearMe extends StatefulWidget {
  static const String routeName = '/NearMe';
  const VaccineDriveNearMe({Key key}) : super(key: key);

  @override
  _VaccineDriveNearMeState createState() => _VaccineDriveNearMeState();
}

class _VaccineDriveNearMeState extends State<VaccineDriveNearMe> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> vaccineDrives = <DocumentSnapshot>[];

    if (globalUserLocation.latitude == -1 && globalUserLocation.longitude == -1)
      return Center(
        child: CircularProgressIndicator(),
      );

    @override
    Container potHoleList = Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('vaccineLocations')
            .orderBy('DateAdded', descending: true)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final vaccineLocationDoc = snapshot.data.documents;
          return ListView.builder(
              shrinkWrap: true,
              itemCount: vaccineLocationDoc.length,
              itemBuilder: (ctx, index) {
                QueryDocumentSnapshot driveData = vaccineLocationDoc[index];
                LatLng p1 =
                    LatLng(driveData['latitude'], driveData['longitude']);
                if (getD(p1, globalUserLocation) > 300)
                  return Container();
                else
                  return Container(
                    margin: index == vaccineLocationDoc.length - 1
                        ? EdgeInsets.only(bottom: 10)
                        : null,
                    child: VaccineListWidget(
                      documentSnapshot: driveData,
                    ),
                  );
              });
        },
      ),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.info,
              color: Colors.black87,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/stepsPage');
            },
          ),
        ],
        title: Text(
          "Vaccination Centers",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xfff2f2f2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: potHoleList,
    );
  }
}
