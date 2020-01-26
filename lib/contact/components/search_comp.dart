import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minne_hack/contact/bloc/bloc.dart';
import "package:material_design_icons_flutter/material_design_icons_flutter.dart";
import 'package:minne_hack/utility/color_scheme.dart';
import 'package:minne_hack/utility/global.dart';

import '../functions.dart';

class SearchComponent extends StatefulWidget {
  @override
  _SearchComponentState createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  TextEditingController _queryController;
  String _query = "";

  void initState() {


    super.initState();
    Global.contactInfo = Trie();
    Map contactData = json.decode(Global.contactFile.readAsStringSync());
    List<String> names = [];
    contactData.forEach((k,v)=> names.add(k));
    Global.contactInfo.fillTrie(names);

    _queryController = TextEditingController();
    _queryController.addListener((){
      setState(()=> _query = _queryController.text);
    });
  }

  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final contactBloc = BlocProvider.of<ContactBloc>(context);
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: sH * 0.2,
            child: Row(
              children: <Widget>[
                Container(
                  width: sW * 0.2,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: () => contactBloc.add(HomeEvent()),
                  ),
                ),
                Container(
                    width: sW * 0.8,
                    child: TextField(
                      controller: _queryController,
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        labelText: "SEARCH",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ))
              ],
            ),
          ),

          Container(
            height: sH * 0.8,
            child: SearchResults(_queryController.text),
          )
        ],
      ),
    );
  }
}


class SearchResults extends StatelessWidget{
  String _query;

  SearchResults(this._query);

  Widget build(BuildContext context){
    final contactBloc = BlocProvider.of<ContactBloc>(context);

    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;

    List<String> items = getResults(this._query);
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int i){
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            width: sW * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: ColorSchemeUI.glowingRed,
            ),
            child: ListTile(
              onTap: (){
                contactBloc.add(ViewerEvent(items[i]));
              },
              subtitle: Container(child: Align(
                alignment: Alignment(0.5, 0.5),
                child: SocialMediaBar()
                )),
              title: Align(
                  alignment: Alignment(-0.6,-0.2),
                  child: Text("${items[i]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontSize: 28,
                  ),),
                ),
            ),
          ),
        );
      },
    );
  }


  List<String> getResults(String query){
    return Global.contactInfo.getResults(query);
  }
}

class SocialMediaBar extends StatelessWidget{

  Widget build(BuildContext context){

    double sW = MediaQuery.of(context).size.width;
    return Row(children: <Widget>[
      Container(
        width: sW * 0.48,
      ),
        Container(
        width: sW * 0.12,
        height: sW * 0.12,
      child: Image.asset("images/gmail_1.png")),
      Container(
        width: sW * 0.12,
        height: sW * 0.12,
      child: Image.asset("images/instagram_1.png")),
      Container(
        width: sW * 0.12,
        height: sW * 0.12,
        child: Image.asset("images/github.png")
      )
    ],);
  }
}