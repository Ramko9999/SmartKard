import 'package:meta/meta.dart';

@immutable
abstract class OnboardingState {}

class LoadingOnboardingState extends OnboardingState {}

class CreateOnboardingState extends OnboardingState {}

class FinishedOnboardingState extends OnboardingState {}
