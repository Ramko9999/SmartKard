import 'dart:async';
import 'package:bloc/bloc.dart';
import '../functions.dart';
import './bloc.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  @override
  OnboardingState get initialState => LoadingOnboardingState();

  @override
  Stream<OnboardingState> mapEventToState(
    OnboardingEvent event,
  ) async* {
    if(event is CreateEvent){
      yield CreateOnboardingState();
    }
    else if(event is FinishCreateEvent){
      yield LoadingOnboardingState();
      await LocalCache.initUser(event.name, event.email);
      yield FinishedOnboardingState();
    }
  }
}
