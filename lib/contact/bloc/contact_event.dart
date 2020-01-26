import 'package:meta/meta.dart';

@immutable
abstract class ContactEvent {

}

class SearchEvent extends ContactEvent{
  final String _query;
  SearchEvent(this._query): super();
}

class ViewEvent extends ContactEvent{
  final Map<String, String> _contactData;
  ViewEvent(this._contactData) : super();
}

class HomeEvent extends ContactEvent{
  
}
