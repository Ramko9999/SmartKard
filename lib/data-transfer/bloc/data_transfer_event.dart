import 'package:meta/meta.dart';

@immutable
abstract class DataTransferEvent {}

class TransferEvent extends DataTransferEvent{}
class WaitEvent extends DataTransferEvent{}
class ProfileEvent extends DataTransferEvent{}
class ContactEvent extends DataTransferEvent{}