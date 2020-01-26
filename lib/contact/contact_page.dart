import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minne_hack/contact/bloc/bloc.dart';
import 'package:minne_hack/data-transfer/connection_page.dart';

import 'bloc/contact_bloc.dart';
import 'components/search_comp.dart';

class ContactPage extends StatelessWidget{

  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        child: ContactPageComponent(),
        builder: (context) => ContactBloc()
      )
    );
  }
}

class ContactPageComponent extends StatelessWidget{

  Widget build(BuildContext context){
    return BlocListener(
      bloc: BlocProvider.of<ContactBloc>(context),
      listener: (BuildContext context, ContactState state){
        if(state is HomeState){
          Navigator.of(context).pop();
          return Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ConnectionPage()
          ));
        }
      },
      child: BlocBuilder(
        bloc: BlocProvider.of<ContactBloc>(context),
        builder: (BuildContext context, ContactState state){
          if(state is SearchState){
            return SearchComponent();
          }
        },
      ),
    );
  }
  
}