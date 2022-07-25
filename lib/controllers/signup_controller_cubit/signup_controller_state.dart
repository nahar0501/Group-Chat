part of 'signup_controller_cubit.dart';

abstract class SignupControllerState {}

class SignupControllerInitial extends SignupControllerState {}
class SignupControllerAuthenticating extends SignupControllerState {}
class SignupControllerSuccess extends SignupControllerState {
  UserModel user;
  SignupControllerSuccess({required this.user});
}
class SignupControllerError extends SignupControllerState {
  String err;
  SignupControllerError({required this.err});
}