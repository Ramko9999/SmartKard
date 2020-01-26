import 'dart:async';
import 'dart:convert';
import 'package:minne_hack/utility/global.dart';

import './bloc.dart';
import 'package:bloc/bloc.dart';


class ContactBloc extends Bloc<ContactEvent, ContactState> {
  @override
  ContactState get initialState => SearchState();

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    if(event is SearchEvent){
      yield SearchState();
    }
    else if(event is HomeEvent){
      yield HomeState();
    }
    else if(event is ViewerEvent){
      yield LoadingState();
      Map data = json.decode(await Global.contactFile.readAsString());
      print(data);
      yield ViewerState(data[event.name]);
    }
  }
}
