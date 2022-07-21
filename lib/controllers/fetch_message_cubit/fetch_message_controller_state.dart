part of 'fetch_message_controller_cubit.dart';


abstract class FetchMessageControllerState {}

class FetchMessageControllerInitial extends FetchMessageControllerState {}
class FetchMessageLoadingState extends FetchMessageControllerState {}
class FetchMessageNewMessageArrived extends FetchMessageControllerState {
  List<MsgModel> msgs;
  FetchMessageNewMessageArrived({required this.msgs});
}
class FetchMessageLoadedState extends FetchMessageControllerState {
  List<MsgModel> msgs;
  FetchMessageLoadedState({required this.msgs});
}
class FetchMessageErrorState extends FetchMessageControllerState {
  String err;
  FetchMessageErrorState({required this.err});
}
