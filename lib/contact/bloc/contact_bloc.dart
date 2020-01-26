import 'dart:async';
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
  }
}
