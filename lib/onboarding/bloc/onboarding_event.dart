import 'package:meta/meta.dart';

@immutable
abstract class OnboardingEvent {}


class CreateEvent extends OnboardingEvent{
}

class FinishCreateEvent extends OnboardingEvent{
  final String name;
  final String email;

  FinishCreateEvent(this.name, this.email) : super();
}