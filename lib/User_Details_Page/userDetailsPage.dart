import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context).settings.arguments;
    Widget body = FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(args['userId'])
          .get(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          final data = snapshot.data;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Color(0xf2f2f2f2),
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
                  child: data['vaccinated']
                      ? Icon(
                          Icons.done,
                          size: 50,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.cancel,
                          size: 50,
                          color: Colors.red,
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(data['userName'],
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "QR Details",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color(0xfff2f2f2),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
        body: body);
  }
}
