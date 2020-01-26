import 'package:meta/meta.dart';

@immutable
abstract class ContactState {}
  
class SearchState extends ContactState {}

class ViewerState extends ContactState {
  Map data;
  ViewerState(this.data): super();
}

class LoadingState extends ContactState {}

class HomeState extends ContactState {}
