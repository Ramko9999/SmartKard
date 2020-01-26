import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class DataTransferBloc extends Bloc<DataTransferEvent, DataTransferState> {
  @override
  DataTransferState get initialState => WaitState();

  @override
  Stream<DataTransferState> mapEventToState(
    DataTransferEvent event,
  ) async* {
    if(event is WaitEvent){
      yield WaitState();
    }
    else if(event is TransferEvent){
      yield TransferState();
    }
    else if(event is ContactEvent){
      yield ContactState();
    }
  }
}
