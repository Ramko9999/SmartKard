import 'package:meta/meta.dart';

@immutable
abstract class DataTransferState {}
  
class WaitState extends DataTransferState {}

class TransferState extends DataTransferState {}

class ProfileState extends DataTransferState {}

class ContactState extends DataTransferState {}