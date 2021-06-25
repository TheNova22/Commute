import 'dart:io';

import 'package:cantin/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  static const String routeName = '/QrScanner';
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Barcode result;
  QRViewController controller;
  bool canGo = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  Future<void> seeIfExists(String uid) async {
    final data =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (data.exists) {
      try {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userIdGlobal)
            .collection('scanned')
            .add({'uid': uid, 'time': DateTime.now()});
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on our end! Please try again later"),
          ),
        );
      } finally {
        canGo = true;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Not a valid Qr Code!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Container(
            height: MediaQuery.of(context).size.height / 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(8),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFf2f2f2),
                        shape: BoxShape.circle,
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
                      child: IconButton(
                          icon: Icon(
                            Icons.flash_on,
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              controller?.toggleFlash();
                            });
                          }),
                    ),
                    if (result != null)
                      TextButton(
                          onPressed: () {
                            print(result.code);
                            seeIfExists(result.code).then((value) {
                              Navigator.pushNamed(context, '/userDetailsPage',
                                  arguments: {'userId': result.code});
                            });
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[100])),
                          child: Text("View Details",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                    Container(
                      margin: EdgeInsets.all(8),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFf2f2f2),
                        shape: BoxShape.circle,
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
                      child: IconButton(
                          icon: Icon(
                            Icons.flip_camera_android,
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              controller?.flipCamera();
                            });
                          }),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      cameraFacing: CameraFacing.front,
      onQRViewCreated: _onQRViewCreated,
      formatsAllowed: [BarcodeFormat.qrcode],
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
