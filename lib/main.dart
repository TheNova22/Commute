import 'package:cantin/Guidleines_Page/guidelines_page.dart';
import 'package:cantin/Log_Page/LogPage.dart';
import 'package:cantin/QR_Scanner/qrScanner.dart';
import 'package:cantin/Settings_Page/settings_page.dart';
import 'package:cantin/Stats_Page/stats_page.dart';
import 'package:cantin/Steps_Page/steps_page.dart';
import 'package:cantin/User_Details_Page/userDetailsPage.dart';
import 'package:cantin/Vaccines_Near_Me_Page/VaccinesNearMePage.dart';
import 'package:cantin/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cantin/Auth_Page/auth_page.dart';
import 'package:cantin/Home_Page/home_page.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'Cantin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.grey,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            changeGlobalUserIdValue(FirebaseAuth.instance.currentUser.uid);
            return HomePage();
          }
          return AuthScreen();
        },
      ),
      routes: {
        VaccineDriveNearMe.routeName: (ctx) => VaccineDriveNearMe(),
        '/guideLinesPage': (ctx) => GuidelinesPage(),
        '/statPage': (ctx) => StatPage(),
        '/logPage': (ctx) => LogPage(),
        '/stepsPage': (ctx) => StepsPage(),
        '/settingsPage': (ctx) => SettingsPage(),
        '/userDetailsPage': (ctx) => UserDetailsPage(),
        QRScanner.routeName: (ctx) => QRScanner(),
      },
    );
    return FutureBuilder(
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.done)
          return app;
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: Firebase.initializeApp(),
    );
  }
}
