import "package:flutter/material.dart";
import 'package:minne_hack/data-transfer/connection_page.dart';
import 'package:minne_hack/onboarding/components/registration_comp.dart';
import 'package:minne_hack/onboarding/functions.dart';
import 'package:minne_hack/utility/transition.dart';

class OnboardingPage extends StatefulWidget{

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  bool hasRecievedData = false;
  bool isValidToMoveOn = false;
  void initState(){
    super.initState();
    LocalCache.loadContactFile().then((b){
      setState((){
        hasRecievedData = true;
        isValidToMoveOn = b;
      });
      if(b){

        Navigator.of(context).push(NoTransition(builder: (context)=> ConnectionPage()));
      }
    });

  }

  
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: hasRecievedData ? isValidToMoveOn ? Container(child: Center(child: CircularProgressIndicator()),) : 
       RegistrationForm() : Container(child: Center(child: CircularProgressIndicator()),)
    );
  }
}
