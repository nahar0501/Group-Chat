part of 'otp_controller_cubit.dart';


abstract class OtpControllerState {}

class OtpControllerInitial extends OtpControllerState {}
class OtpControllerSuccessState extends OtpControllerState {
  String id;
  OtpControllerSuccessState({required this.id});
}
class OtpControllerLoadingState extends OtpControllerState {
  String msg;
  OtpControllerLoadingState({required this.msg});
}
class OtpExpiryState extends OtpControllerState{}
class OtpSentState extends OtpControllerState{
  String verificationID;
  OtpSentState({required this.verificationID});
}
class OtpControllerFetchedState extends OtpControllerState {
  String otp;
  OtpControllerFetchedState({required this.otp});
}
class OtpControllerLoadedState extends OtpControllerState {
  String msg;
  OtpControllerLoadedState({required this.msg});
}
class OtpControllerErrorState extends OtpControllerState {
  String err;
  OtpControllerErrorState({required this.err});
}

