import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minne_hack/data-transfer/bloc/bloc.dart';
import 'package:minne_hack/utility/color_scheme.dart';
import 'package:minne_hack/utility/global.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WaitComponent extends StatelessWidget {
  Widget build(BuildContext context) {
    final dtBloc = BlocProvider.of<DataTransferBloc>(context);
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Container(
         
          height: sH * 0.7,
          width: sW,
          color: Colors.white,
          child: Center(
            child: Container(
              width: sW * 0.7,
              height: sW * 0.7,
              child: QrImage(
                foregroundColor: ColorSchemeUI.glowingRed,
                data: json.encode(Global.userDataFile.readAsStringSync()),
              ),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          height: sH * 0.3,
          width: sW,
          child: Row(
            children: <Widget>[
              Container(
                width: sW * 0.1,
              ),
              Container(
                
                width: sW * 0.15,
                height: sH * 0.3,
                child: Align(
                  alignment: Alignment(0, 0.5),
                  child: ClipOval(
                    child: Material(
                      color: ColorSchemeUI.glowingRed, // button color
                      child: InkWell(
                        splashColor: Colors.red, // inkwell color
                        child: SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            )),
                        onTap: () {
                          dtBloc.add(ProfileEvent());
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: sW * 0.15,
              ),
              Container(
                width: sW * 0.2,
                child: Container(
                  height: sH * 0.3,
                  child: Align(
                    alignment: Alignment(0, -0.5),
                    child: Container(
                  
                      width: sW * 0.3,
                      height: sH * 0.3,
                      child: InkWell(
                        splashColor: Colors.red,
                        // inkwell color
                        child: Container(
                          child: Image.asset(
                            "images/sharingan.png",
                            scale: 2,
                          ),
                        ),
                        onTap: () {
                          dtBloc.add(ScanEvent());
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: sW * 0.15,
              ),
              Container(
                color: Colors.white,
                width: sW * 0.15,
                child: Container(
                  height: sH * 0.3,
                  child: Align(
                    alignment: Alignment(0, 0.5),
                    child: ClipOval(
                      child: Material(
                        color: ColorSchemeUI.glowingRed, // button color
                        child: InkWell(
                          splashColor: Colors.red, // inkwell color
                          child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(
                                Icons.people,
                                color: Colors.white,
                              )),
                          onTap: () {
                            dtBloc.add(ContactEvent());
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: sW * 0.1,
              ),
            ],
          ),
        )
      ],
    );
  }
}
