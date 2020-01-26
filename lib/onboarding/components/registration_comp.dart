

import 'package:flutter/material.dart';
import 'package:minne_hack/data-transfer/connection_page.dart';
import 'package:minne_hack/onboarding/functions.dart';
import 'package:minne_hack/utility/transition.dart';

class RegistrationForm extends StatefulWidget{
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController _emailController;

  TextEditingController _nameController;

  _RegistrationFormState(){
    _emailController = TextEditingController(text:"");
    _nameController = TextEditingController(text:"");
  }


  @override
  void dispose(){
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }


  void _submit() async {
    LocalCache.initUser(_nameController.text, _emailController.text).then((_){
      Navigator.of(context).push(NoTransition(builder: (context)=> ConnectionPage()));
    });
  }


  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;

    return Container(
        width: sW,
        height: sH,
        child: Column(
          children: <Widget>[
            Container(
              width: sW,
              height: sH * 0.25,
              child: Align(
                alignment: Alignment(-0.8, 1),
                child: Text(
                  "Smart",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 70,
                  ),
                ),
              ),
            ),
            Container(
              width: sW,
              height: sH * 0.25,
              child: Align(
                alignment: Alignment(-0.8, -1),
                child: Text(
                  "Kard",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 70,
                  ),
                ),
              ),
            ),
            Container(
                width: sW,
                height: sH * 0.5,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: sW * 0.8,
                        child: TextField(
                          controller: _emailController,
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
                      Padding(
                        padding: const EdgeInsets.only(top:14),
                        child: Container(
                          width: sW * 0.8,
                          child: TextField(
                            controller: _nameController,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:14),
                        child: Container(
                          child: Align(
                            alignment: Alignment(0.7, 0),
                            child: RaisedButton(
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17)
                              ),
                              child: Text("TAG IT", style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                fontSize: 16
                              )),
                              onPressed: ()=> _submit()
                            ),
                          ),
                        ),
                      )
                    
                    ],
                  ),
                )),
              
          ],
        ),
        color: Colors.white);
  }
}