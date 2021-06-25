import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Settings_Page_widgets/settings_button.dart';
import 'Settings_Page_widgets/settings_title.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = "/SettingsPage";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
        // centerTitle: true,
        backgroundColor: Color(0xfff2f2f2),
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingsTitle(title: "Pandemic"),
            SettingsButton(
                title: "Guidelines",
                onTap: () {
                  Navigator.pushNamed(context, '/guideLinesPage');
                },
                leading: Icon(Icons.info_outline, color: Colors.black87)),
            SettingsButton(
                title: "Steps To Get Vaccinated",
                onTap: () {
                  Navigator.pushNamed(context, '/stepsPage');
                },
                leading:
                    Icon(Icons.coronavirus_outlined, color: Colors.black87)),
            SettingsTitle(title: "Account"),
            SettingsButton(
                title: "Edit Details",
                onTap: () {},
                leading:
                    Icon(Icons.keyboard_arrow_right, color: Colors.black87)),
            SettingsButton(
              title: "Change Password",
              onTap: () {},
              leading: Icon(Icons.lock_outline, color: Colors.black87),
            ),
            SettingsButton(
              title: "Log Out",
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pop();
                });
              },
              leading: Icon(Icons.logout, color: Colors.red),
            ),
            SettingsTitle(title: "Preferences"),
            SettingsButton(
              title: "Text Size",
              onTap: () {},
              leading: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  "Medium",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
            ),
            SettingsButton(
              title: "Language",
              onTap: () {},
              leading: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  "English",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
            ),
            SettingsTitle(
              title: "Application",
            ),
            SettingsButton(
              title: "Help",
              onTap: () {},
              leading: Icon(
                Icons.help_outline,
                color: Colors.black87,
              ),
            ),
            SettingsButton(
              title: "Contact Us",
              onTap: () {},
              leading: Icon(
                Icons.mail_outline,
                color: Colors.black87,
              ),
            ),
            SettingsButton(
              title: "About Us",
              onTap: () {},
              leading: Icon(
                Icons.devices,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
