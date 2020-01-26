import "package:flutter/material.dart";
import 'package:permission_handler/permission_handler.dart';
import "package:r_scan/r_scan.dart";

class ScanComponent extends StatefulWidget{


  @override
  _ScanComponentState createState() => _ScanComponentState();
}

class _ScanComponentState extends State<ScanComponent> {
  bool _isCameraInitalized = false;
  bool _cameraPermission = true;
  RScanController _controller;

  void initState(){
    super.initState();
    initControllers();
  }

  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  void initControllers(){
    _controller = RScanController();
    _controller.addListener((){
      final result = _controller.result;
      if(result != null){
        print(result.message);
      }
    });
  }

  //get a list of permissions that are still denied
  Future<bool> getPermissionsThatNeedToBeChecked(
      PermissionGroup cameraPermission,
      PermissionGroup microphonePermission) async {

        print("getPermissions");
    PermissionStatus cameraPermStatus =
        await PermissionHandler().checkPermissionStatus(cameraPermission);
    if (cameraPermStatus == PermissionStatus.denied) {
      return false;
    }

    return true;
  }



  Widget build(BuildContext context){
    
    return Container(
      child: FutureBuilder(
        future: getPermissionsThatNeedToBeChecked(PermissionGroup.camera, PermissionGroup.microphone),
        builder: (BuildContext context, var snapshot){
          if(snapshot.hasData){
            if(snapshot.data){
            return RScanView(
              controller: _controller 
            );
          }
          else{
            return Container(
              color: Colors.white,
              child: Center(child: Text("Camera permissions denied, click here to request")),
            );
          }
          }
          else{
            return Container(
              color: Colors.white,
              child: Center(child: Text("Loading...")),
            );
          }
          
        },
      ),
    );
  }
}

