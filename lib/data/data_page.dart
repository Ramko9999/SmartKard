import "package:flutter/material.dart";
import 'package:minne_hack/utility/global.dart';
import "dart:convert";


class DataPage extends StatelessWidget{

  final Map mediaIcons = {"INSTA": "insta.png", "GIT": "git.png" };
  final Map mediaUrl = {"INSTA": "https://instagram.com/", "GIT": "https://github.com/"};

  Widget build(BuildContext context){
    return Container();
  }
}

class DataEditingWidget extends StatefulWidget{
  Map _data;

  @override
  _DataEditingWidgetState createState() => _DataEditingWidgetState();
}

class _DataEditingWidgetState extends State<DataEditingWidget> {


  void loadData() async {
    Future<String> encodedData = Global.userDataFile.readAsString();
    Map data = json.decode(await encodedData);
    setState(()=> widget._data = data);
  }

  Widget build(BuildContext context){
    return Container();
  }
}