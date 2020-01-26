import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minne_hack/contact/bloc/bloc.dart';
import "package:material_design_icons_flutter/material_design_icons_flutter.dart";
import 'package:minne_hack/utility/color_scheme.dart';

class SearchComponent extends StatefulWidget {
  @override
  _SearchComponentState createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  TextEditingController _queryController;

  void initState() {
    super.initState();
    _queryController = TextEditingController();
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
            child: SearchResults(),
          )
        ],
      ),
    );
  }
}


class SearchResults extends StatelessWidget{

  Widget build(BuildContext context){
    
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;

    List<Map> items = [
      {"firstName": "Ramki", "lastName": "Pitchala"},
      {"firstName": "Rai", "lastName": "Pitala"},
      {"firstName": "Ashwin", "lastName": "Murali"}
    ];


    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int i){
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: ColorSchemeUI.glowingRed,
            ),
            child: ListTile(
              subtitle: Container(child: Align(
                alignment: Alignment(0.5, 0.5),
                child: SocialMediaBar()
                )),
              title: Align(
                  alignment: Alignment(-0.6,-0.2),
                  child: Text("${items[i]["firstName"]} ${items[i]["lastName"]}",
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
}

class SocialMediaBar extends StatelessWidget{

  Widget build(BuildContext context){

    double sW = MediaQuery.of(context).size.width;
    return Row(children: <Widget>[
      Container(
        width: sW * 0.6,
      ),
        Container(
        width: sW * 0.12,
        height: sW * 0.12,
      child: Image.asset("images/gmail_1.png")),
      Container(
        width: sW * 0.12,
        height: sW * 0.12,
      child: Image.asset("images/instagram_1.png"))
    ],);
  }
}