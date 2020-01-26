import 'package:meta/meta.dart';

@immutable
abstract class ContactEvent {

}

class SearchEvent extends ContactEvent{
  final String _query;
  SearchEvent(this._query): super();
}

class ViewerEvent extends ContactEvent{
  final String name;
  ViewerEvent(this.name) : super();
}

class HomeEvent extends ContactEvent{
  
}
