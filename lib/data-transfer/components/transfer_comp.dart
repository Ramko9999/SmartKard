import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:minne_hack/data-transfer/bloc/bloc.dart';
import 'package:minne_hack/utility/color_scheme.dart';


class TransferComponent extends StatefulWidget {


  @override
  _TransferComponentState createState() => _TransferComponentState();
}

class _TransferComponentState extends State<TransferComponent> {


  void initState(){
    super.initState();
    startReadStream();
    //startWriteStream();
  }
  
  void startReadStream(){
    print("started");
    Stream nfcReadStream = readStream();
    nfcReadStream.listen((response){
      print("Response recieved");
      print(response.content);
    });
  }

  void startWriteStream(){
    print("writed");
    Stream nfcWriteStream = writeStream();
    nfcWriteStream.listen((response){
      print("Response wrote");
      print(response.toString());
    });
  }

  
  Stream readStream() async *{
    while(true){
      final response = await FlutterNfcReader.read();
      yield response;
    }
  }

  Stream writeStream() async *{
    while(true){
      final response = await FlutterNfcReader.write("DATA", "Hello beta");
      yield response;
    }
  }
  



  Widget build(BuildContext context) {
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;

    final authBloc = BlocProvider.of<DataTransferBloc>(context);

    return Container(
      color: Colors.black,
      width: sW,
      height: sH,
      child: Column(
        children: <Widget>[
          Container(
            width: sW,
            height: sH * 0.15,
            child: Align(
              child: Container(
                child: Text(
                  "Put Phones Nearby",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 24),
                ),
              ),
            ),
          ),
          Container(
            height: sH * 0.4,
            child: Image.asset("images/NFC_phones.png"),
          ),
          Container(
            height: sH * 0.1,
          ),
          Container(
            height: sH * 0.07,
            child: Align(
              child: Container(
                child: Text(
                  "Ramki Pitchala",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 24,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            height: sH * 0.1,
          ),
          Container(
            width: sW * 0.7,
            height: sH * 0.18,
            child: Align(
              child: RaisedButton(
                  color: ColorSchemeUI.glowingRed,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  onPressed: () {
                    authBloc.add(WaitEvent());
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18,
                        color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
