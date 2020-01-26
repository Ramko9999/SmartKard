import 'package:meta/meta.dart';

@immutable
abstract class DataTransferState {}
  
class WaitState extends DataTransferState {}
class ScanState extends DataTransferState {}
class ProfileState extends DataTransferState {}
class ContactState extends DataTransferState {}