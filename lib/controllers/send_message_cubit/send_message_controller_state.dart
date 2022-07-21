part of 'send_message_controller_cubit.dart';


abstract class SendMessageControllerState {}

class FailureState extends SendMessageControllerState {
  String err;
  FailureState({required this.err});
}
class SendingState extends SendMessageControllerState {}
class InitialState extends SendMessageControllerState {}
class SentState extends SendMessageControllerState {}
