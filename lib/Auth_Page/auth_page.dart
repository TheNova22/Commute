import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import '../globals.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  var _isLoading = false;
  var _isLogin = true;
  String _userEmail = "";
  String _password = "";
  String _userName = "";

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    if ((isValid && !_isLogin) || (_isLogin && isValid)) {
      FocusScope.of(context).unfocus();
      _formKey.currentState.save();

      _submitAuthForm(
        _userEmail.trim(),
        _password,
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  void _submitAuthForm(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) async {
// authResult was named UserCredential
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        changeGlobalUserIdValue(authResult.user.uid);

        String imageUrl = 'none';
        final rand = Random();
        final num = rand.nextInt(100);
        final truth = num % 5 == 0;
        FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'userName': userName,
          'email': email,
          'imageUrl': imageUrl,
          'userId': authResult.user.uid,
          'vaccinated': truth,
          'isOwner': false,
          'name_of_vaccine_if_vaccinated':
              truth ? (num % 2 == 0 ? 'Covaxin' : 'Covishield') : 'none'
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .collection('scanned')
            .add({'uid': auth.currentUser.uid, 'time': DateTime.now()});
        Timer(Duration(seconds: 5), () {});
      }
    } on PlatformException catch (error) {
      setState(() {
        _isLoading = false;
      });
      var message = "Check your credentials please!";
      if (error.message != null) {
        message = error.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
        ),
      );
    }
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _email = new FocusNode();
    FocusNode _name = new FocusNode();

    FocusNode _passwordFocusNode = new FocusNode();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: h,
      decoration: BoxDecoration(
        color: Color(0xFFF9DF84),
      ),
      child: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Center(child: EarthImage()),
                        height: 220,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20),
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF0F0F7),
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextFormField(
                                  focusNode: _email,
                                  key: ValueKey("Aadhar"),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      suffixIcon: Icon(
                                        Icons.mobile_screen_share_outlined,
                                        color: Colors.blue,
                                      ),
                                      border: InputBorder.none),
                                  onChanged: (value) {
                                    _userEmail = value;
                                  },
                                  onFieldSubmitted: (str) {
                                    FocusScope.of(context).requestFocus(
                                        _isLogin ? _passwordFocusNode : _name);
                                  },
                                ),
                              ),
                              if (!_isLogin)
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      bottom: 20, left: 20, right: 20),
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF0F0F7),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextFormField(
                                    focusNode: _name,
                                    key: ValueKey("Name"),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        hintText: "Name",
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      _userName = value;
                                    },
                                    onFieldSubmitted: (str) {
                                      FocusScope.of(context)
                                          .requestFocus(_passwordFocusNode);
                                    },
                                  ),
                                ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20),
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF0F0F7),
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextFormField(
                                  focusNode: _passwordFocusNode,
                                  obscureText: true,
                                  key: ValueKey("password"),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      suffixIcon: Icon(
                                        Icons.vpn_key,
                                      ),
                                      border: InputBorder.none),
                                  onChanged: (value) {
                                    _password = value;
                                  },
                                  onFieldSubmitted: (str) {
                                    _trySubmit();
                                  },
                                ),
                              ),
                            ],
                          )),
                      if (!_isLoading)
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFF5B77DE)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)))),
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });
                              _trySubmit();
                            },
                            child: Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                width: w / 1.5,
                                alignment: Alignment.center,
                                child: Text(
                                  _isLogin ? "Log In" : "Sign Up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ))),
                      if (!_isLoading)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (_isLogin)
                                  ? Text("Don't have an account?")
                                  : Text("Already have an account?"),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });
                                  },
                                  child: (_isLogin)
                                      ? Text("Sign Up")
                                      : Text("Sign In"))
                            ]),
                      if (_isLoading)
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class FirebaseStorage {}

class EarthImage extends StatefulWidget {
  @override
  _EarthImageState createState() => _EarthImageState();
}

class _EarthImageState extends State<EarthImage> {
  double _height = 200;
  Timer timer;
  void _move() {
    if (_height == 200) {
      _height = 175;
    } else {
      _height = 200;
    }
    setState(() {});
  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _move());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment.center,
      height: _height,
      child: Image.asset(
        "assets/virus.png",
        fit: BoxFit.fitHeight,
      ),
      duration: Duration(milliseconds: 1000),
    );
  }
}
