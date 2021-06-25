import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StepsPage extends StatelessWidget {
  _launchURL() async {
    const url = 'https://www.cowin.gov.in/home';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Color(0xfff2f2f2),
        title: Text(
          "Steps To Get Vaccinated",
          style: TextStyle(fontSize: 22, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                "1. Register for Covid-19 vaccine by logging on “www.cowin.gov.in”’. Enter your mobile number to receive OTP for verification via SMS. Click on the ‘Verify’ button to complete the registration process.",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Text(
                "2. After registering on the CoWIN website, a new ‘Registration of Vaccination’ page will appear. Enter details like Photo ID type, Photo ID Proof number, name, date of birth, gender and other details. Then click on the Register button. You will receive necessary details regarding vaccination via an SMS. Check the details properly. You will get a Beneficiary Reference ID at the time of registering for the vaccine, save this ID.",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Text(
                  "3. You can add 3 more people linked to the same account on CoWIN website. To do this, click the ‘Add More’ button at the bottom right side of the Account Details page. You will need to enter similar details for other people to register them for vaccination.",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Text(
                  "4. On any web browser, visit www.cowin.gov.in. Scroll down and you will see a Map and dialogue box that reads ‘Enter place/address/eLoc’. Enter location details and hit the Go button. To know the nearing vaccine centers, you can also use our application.",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Text(
                "5. You can schedule Appointment from the Account Details page on CoWIN website. Click on the Calendar icon placed in front of each registered user or directly click on the Schedule Appointment button. You will get redirected to Book Appointment for Vaccination page. On this page, search the vaccination centre of choice by State, District, Block and Pin code. Click on Center name and it will show available slots (date and capacity). Then click on the Book button and after that a new ‘Appointment Confirmation’ page will appear. Check all the details properly and click the Confirm button.",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Text(
                "You will be now all set to get yourself vaccinated.",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                  child: TextButton(
                child: Text("Visit The Site"),
                onPressed: () {
                  _launchURL();
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
