part of 'login_controller_cubit.dart';

abstract class LoginControllerState {}

class LoginControllerInitial extends LoginControllerState {}
class LoginControllerAuthenticating extends LoginControllerState {}
class LoginControllerSuccess extends LoginControllerState {
  UserModel user;
  LoginControllerSuccess({required this.user});
}
class LoginControllerError extends LoginControllerState {
  String err;
  LoginControllerError({required this.err});
}
