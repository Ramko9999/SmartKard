import "package:flutter/material.dart";
import 'package:minne_hack/contact/components/profile_component.dart';
import 'package:minne_hack/data-transfer/connection_page.dart';
import 'package:minne_hack/utility/color_scheme.dart';
import 'package:minne_hack/utility/global.dart';
import "dart:convert";


class DataPage extends StatelessWidget{


  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DataEditingWidget(),
    );
  }
}

class DataEditingWidget extends StatefulWidget{
  @override
  _DataEditingWidgetState createState() => _DataEditingWidgetState();
}

class _DataEditingWidgetState extends State<DataEditingWidget> {
  String fName = "";
  String lName = "";
  String email = "";
  String instagram = "";
  String github = "";
  Map data;

  void initState(){
    super.initState();
    loadData();
  }
  void loadData() async {
    Future<String> encodedData = Global.userDataFile.readAsString();
    Map userData = json.decode(await encodedData);

    setState((){
      this.data = userData;
    });
  }

  Widget build(BuildContext context){
    double sH  = MediaQuery.of(context).size.height;
    double sW = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
            height: sH * 0.15,
            child: Row(
              children: <Widget>[
                Container(
                  width: sW * 0.2,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: (){
                      Global.userDataFile.writeAsStringSync(json.encode(this.data));
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ConnectionPage()));
                    }),
                  ),
              ])),

          Container(
            height: sH * 0.4,
            width: sW * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: ColorSchemeUI.glowingRed
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: sH * 0.10,
                  child: Align(
                    alignment: Alignment(-0.7, 0.3),
                        child: Text(this.data["firstName"], style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 28,
                      color: Colors.white
                    ),),
                  ),
                  ),
                  Container(
                  height: sH * 0.10,
                  child: Align(
                      alignment: Alignment(-0.7,-1),
                      child: Text(this.data["lastName"], style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 28,
                      color: Colors.white
                    ),),
                  ),
                  ),
                  Container(
                    height: sH * 0.2,
                    child: this.data == null ? CircularProgressIndicator() : MediaRow(this.data)
                    ),
              ],
            ),
          ),
          Container(
                        width: sW * 0.8,
                        child: TextField(
                          onSubmitted: (val){
                            setState((){
                              String name = val;
                              List<String> names = val.split(" ");
                              if(names.length == 2){
                                this.data["firstName"] = names[0];
                                this.data["lastName"] = names[1];
                              }
                              else if(names.length == 1){
                                this.data["firstName"] = names[0];
                                this.data["lastName"] = "";
                              }
                              else{
                                this.data["firstName"] = "";
                                this.data["lastName"] = "";
                              }
                            });
                          },
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400
                          ),
                          decoration: InputDecoration(
                            labelText: "NAME",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat",
                          ),
                          border: UnderlineInputBorder(borderSide: BorderSide(
                            color: Colors.black,
                            width: sW * 0.8,
                            style: BorderStyle.solid
                          ))
                          ),
                        ),
                      ),
                      Container(
                        width: sW * 0.8,
                        child: TextField(
                          onSubmitted: (val){
                            setState((){
                              if(val.trim() == ""){
                                this.data.remove("email");
                              }
                              else{
                                this.data["email"] = val;
                              }
                              
                          });},
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400
                          ),
                          decoration: InputDecoration(
                            labelText: "EMAIL",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat",
                          ),
                          border: UnderlineInputBorder(borderSide: BorderSide(
                            color: Colors.black,
                            width: sW * 0.8,
                            style: BorderStyle.solid
                          ))
                          ),
                        ),
                      ),
                      Container(
                        width: sW * 0.8,
                        child: TextField(
                          onSubmitted: (val){
                            setState((){
                              if(val.trim() == "" ){
                                this.data.remove("instagram");
                              }
                              else{
                                this.data["instagram"] = val;
                              }
                            });
                          },
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400
                          ),
                          decoration: InputDecoration(
                            labelText: "Instagram",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat",
                          ),
                          border: UnderlineInputBorder(borderSide: BorderSide(
                            color: Colors.black,
                            width: sW * 0.8,
                            style: BorderStyle.solid
                          ))
                          ),
                        ),
                      ),
                      Container(
                        width: sW * 0.8,
                        child: TextField(
                          onSubmitted: (val){
                            setState((){
                              if(val.trim() == "" ){
                                this.data.remove("github");
                              }
                              else{
                                this.data["github"] = val;
                              }
                            });
                          },
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400
                          ),
                          decoration: InputDecoration(
                            labelText: "github",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat",
                          ),
                          border: UnderlineInputBorder(borderSide: BorderSide(
                            color: Colors.black,
                            width: sW * 0.8,
                            style: BorderStyle.solid
                          ))
                          ),
                        ),
                      ),
      ],
    );
  }
}

