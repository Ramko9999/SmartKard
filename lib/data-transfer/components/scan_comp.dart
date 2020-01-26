import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minne_hack/data-transfer/bloc/bloc.dart';
import 'package:minne_hack/utility/global.dart';
import 'package:permission_handler/permission_handler.dart';

class ScannerComponent extends StatefulWidget {
  State<ScannerComponent> createState() {
    return _ScannerComponentState();
  }
}

class _ScannerComponentState extends State<ScannerComponent> {
  CameraController _mainCamera; //camera that will give us the feed
  bool _isCameraInitalized = false;
  bool _cameraPermission = true;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _processor = StreamController();
  String prevName = "";

  //handles running the actual scanner camera stream
  void runStream() {
    _mainCamera.startImageStream((image) async {
      FirebaseVisionImageMetadata metadata;

      //metadata tag for the for image format.
      //source https://github.com/flutter/flutter/issues/26348
      metadata = FirebaseVisionImageMetadata(
          rawFormat: image.format.raw,
          size: Size(image.width.toDouble(), image.height.toDouble()),
          planeData: image.planes
              .map((plane) => FirebaseVisionImagePlaneMetadata(
                  bytesPerRow: plane.bytesPerRow,
                  height: plane.height,
                  width: plane.width))
              .toList());

      FirebaseVisionImage visionImage =
          FirebaseVisionImage.fromBytes(image.planes[0].bytes, metadata);

      List<Barcode> barcodes = await FirebaseVision.instance
          .barcodeDetector()
          .detectInImage(visionImage);

      for (Barcode barcode in barcodes) {
        Map data = json.decode(barcode.rawValue);
        String name = data["firstName"] + data["lastName"];
        if(name != prevName){
          prevName = name;
          String firstName = data["firstName"];
          String lastName = data["lastName"];

            Map contacts = json.decode(await Global.contactFile.readAsString());
            
            contacts["$firstName $lastName"] = data;

            Global.contactFile.writeAsStringSync(json.encode(contacts));

            //show scaffold here
            Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Color.fromRGBO(46, 204, 113, 1),
                content: Text("${firstName} ${lastName}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Lato', color: Colors.white, fontSize: 18)),
                duration: Duration(milliseconds: 500)));
                
        }
      
      }
    });
  }

  //get a list of permissions that are still denied
  Future<List> getPermissionsThatNeedToBeChecked(
      PermissionGroup cameraPermission,
      PermissionGroup microphonePermission) async {
    PermissionStatus cameraPermStatus =
        await PermissionHandler().checkPermissionStatus(cameraPermission);
    PermissionStatus microphonePermStatus =
        await PermissionHandler().checkPermissionStatus(microphonePermission);

    List<PermissionGroup> stillNeedToBeGranted = [];

    if (cameraPermStatus == PermissionStatus.denied) {
      stillNeedToBeGranted.add(cameraPermission);
    }

    if (microphonePermStatus == PermissionStatus.denied) {
      stillNeedToBeGranted.add(microphonePermission);
    }

    return stillNeedToBeGranted;
  }

  //create camera based on permissions
  void createCamera() async {
    List<PermissionGroup> permList = await getPermissionsThatNeedToBeChecked(
        PermissionGroup.camera, PermissionGroup.microphone);

    if (permList.length == 0) {
      //get all the avaliable cameras
      availableCameras().then((allCameras) {
        _mainCamera = CameraController(allCameras[0], ResolutionPreset.low);

        _mainCamera.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {
            _isCameraInitalized = true;
          }); //show the actual camera

          runStream();
      
    }); 
      });
    }
    else {
      setState(() {
        _cameraPermission = false;
      });
    }
  }

  //request permissions and check until all are requestsed
  void requestPermStatus(List<PermissionGroup> permissionGroups) {
    bool allAreAccepted = true;
    PermissionHandler()
        .requestPermissions(permissionGroups)
        .then((permissionResult) {
      permissionResult.forEach((k, v) {
        if (v == PermissionStatus.denied) {
          allAreAccepted = false;
        }
      });
      if (allAreAccepted) {
        setState(() {
          _cameraPermission = true;
        });
        createCamera();
      }
    });
  }

  void initState() {
    super.initState();
    createCamera();
  }

  void dispose() {
    if (_mainCamera != null) {
      _mainCamera.dispose();
    }

    super.dispose();
  }

  Widget build(BuildContext context) {
    final dtBloc = BlocProvider.of<DataTransferBloc>(context);
    //check first whether camera is init
    if (_isCameraInitalized) {
      //check whether camera is already is streaming images
      if (!_mainCamera.value.isStreamingImages) {
        runStream();
      }
    }

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight,
      width: screenWidth,
      child: Column(
        children: <Widget>[
          Container(
            height: screenHeight * 0.2,
            child: Container(
              child: Align(
                alignment: Alignment(-0.9, 0),
                child: InkWell(
                    child: Container(
                      child: Image.asset("images/Cross.png"),
                    ),
                    onTap: () {
                      dtBloc.add(WaitEvent());
                    }),
              ),
            ),
          ),
          Container(
            height: screenHeight * 0.2,
            child: Container(
              height: screenHeight * 0.4,
              child: Align(
                alignment: Alignment(0, -0.2),
                child: Text(
                  "Scan the QR Code",
                  style: TextStyle(fontFamily: "Montserrat", fontSize: 24),
                ),
              ),
            ),
          ),
          Container(
            height: screenHeight * 0.35,
            width: screenWidth * 0.8,
            child: Center(
              child: Container(
                child: _cameraPermission
                    ? _isCameraInitalized
                        ? Platform.isIOS
                            ? RotationTransition(
                                child: CameraPreview(_mainCamera),
                                turns: AlwaysStoppedAnimation(270 / 360))
                            : Container(
                                height: screenHeight * 0.35,
                                child: Align(
                                    alignment: Alignment(0, -1),
                                    child: CameraPreview(_mainCamera)))
                        : Container(
                            child: Center(
                                child: Text(
                              "Loading",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 24,
                              ),
                            )),
                          )
                    : GestureDetector(
                        onTap: () {
                          getPermissionsThatNeedToBeChecked(
                                  PermissionGroup.camera,
                                  PermissionGroup.microphone)
                              .then((permGroupList) {
                            requestPermStatus(permGroupList);
                          });
                        },
                        child: Container(
                          child: Center(
                            child: Text(Platform.isAndroid
                                ? "You have denied camera permissions, please accept them by clicking on this text"
                                : "You have denied camera permissions, please go to settings to activate them"),
                          ),
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static StreamController() {}
}
