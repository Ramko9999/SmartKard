import 'package:meta/meta.dart';

@immutable
abstract class ContactState {}
  
class SearchState extends ContactState {}

class ProfileViewState extends ContactState {}

class LoadingState extends ContactState {}

class HomeState extends ContactState {}
