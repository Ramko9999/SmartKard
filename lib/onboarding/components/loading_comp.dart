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
  }

  
  Widget build(BuildContext context){
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}