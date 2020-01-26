import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minne_hack/onboarding/bloc/bloc.dart';

import '../functions.dart';


class LoadingComponent extends StatefulWidget{

  @override
  _LoadingComponentState createState() => _LoadingComponentState();
}

class _LoadingComponentState extends State<LoadingComponent> {

  void initState(){
    super.initState();
    Future.delayed(Duration.zero, (){
      checkFile();
    });  
  }

  void checkFile() async {
   bool result = await LocalCache.loadContactFile();
   if(!result){
     print("Result is false");
     BlocProvider.of<OnboardingBloc>(context).add(CreateEvent());
   }
   else{

   }
  }
  
  Widget build(BuildContext context){
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}