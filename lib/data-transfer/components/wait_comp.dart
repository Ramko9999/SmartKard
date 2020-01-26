import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minne_hack/data-transfer/bloc/bloc.dart';
import 'package:minne_hack/utility/color_scheme.dart';

class WaitComponent extends StatelessWidget {
  
  Widget build(BuildContext context) {

    final dtBloc = BlocProvider.of<DataTransferBloc>(context);
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Container(
          height: sH * 0.8,
          width: sW,
          color: Colors.black,
          child: Center(
              child: ClipOval(
                  child: Material(
            color: ColorSchemeUI.glowingRed,
            child: InkWell(
              splashColor: Colors.red, // inkwell color
              child: Container(
                height: sH * 0.3,
                width: sH * 0.3,
                child: Center(child: Text("Connect", 
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontSize: 36

                ),)),
              ),
              onTap: () {
                dtBloc.add(TransferEvent());
              },
            ),
          ))),
        ),
        Container(
          color: Colors.black,
          height: sH * 0.2,
          width: sW,
          child: Row(
            
            children: <Widget>[
              Container(width: sW * 0.1,),
               Container(
                  width: sW * 0.3,
                  child: Container(
                    width: sW * 0.2,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26)
                      ),
                      onPressed: ()=> null,
                      color: ColorSchemeUI.glowingRed,
                      child: Text("Profile", style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 18
                      ),),
                    ),
                  )),
                  Container(width: sW * 0.2,),
                  Container(
                  width: sW * 0.3,
                  child: Container(
                    width: sW * 0.2,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26)
                      ),
                      onPressed: (){
                        dtBloc.add(ContactEvent());
                        print("Presssed Contact");
                      },
                      color: ColorSchemeUI.glowingRed,
                      child: Text("Contacts", style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontSize: 18
                      ),),
                    ),
                  )),
                  Container(width: sW * 0.1,),

            ],
          ),
        )
      ],
    );
  }
}
