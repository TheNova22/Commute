import 'package:cantin/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogPage extends StatelessWidget {
  const LogPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Scan-Log",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xfff2f2f2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userIdGlobal)
            .collection('scanned')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            final scanDoc = snapshot.data.documents;

            return ListView.builder(
                itemCount: scanDoc.length,
                itemBuilder: (ctx, index) {
                  final s = scanDoc[index].data();

                  return logTile(
                      time: (s['time'] as Timestamp).toDate(), uid: s['uid']);
                });
          }
        },
      ),
    );
  }
}

class logTile extends StatelessWidget {
  final DateTime time;
  final String uid;
  const logTile({Key key, this.time, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMd().add_jm().format(time);
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          final data = snapshot.data;
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ListTile(
              minVerticalPadding: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              title: Text(data['userName']),
              subtitle: Text(date.toString()),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: Text(
                  data['vaccinated'] ? 'Vaccinated' : 'Not Vaccinated',
                  style: TextStyle(
                      color: data['vaccinated'] ? Colors.green : Colors.red),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
