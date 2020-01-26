import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minne_hack/data-transfer/connection_page.dart';

import 'bloc/onboarding_bloc.dart';
import 'bloc/onboarding_state.dart';
import 'components/loading_comp.dart';
import 'components/registration_comp.dart';

class OnboardingPage extends StatelessWidget{

  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        child: OnboardingPageComponent(),
        builder: (context) => OnboardingBloc()
        ),
    );
  }
}

class OnboardingPageComponent extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: BlocProvider.of<OnboardingBloc>(context),
        listener: (BuildContext context, OnboardingState state){
          if(state is FinishedOnboardingState){
            return Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ConnectionPage()
            ));
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<OnboardingBloc>(context),
          builder: (BuildContext context, OnboardingState state) {
            if (state is LoadingOnboardingState) {
              return LoadingComponent();
            } else if (state is CreateOnboardingState) {
              return RegistrationForm();
            }
            
          },
        ));
  }
}
