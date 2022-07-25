part of 'profile_controller_cubit.dart';


abstract class ProfileControllerState {}

class ProfileControllerInitial extends ProfileControllerState {}
class ProfileControllerLoading extends ProfileControllerState {}
class ProfileControllerLoaded extends ProfileControllerState {
  UserModel userModel;
  ProfileControllerLoaded({required this.userModel});
}
class ProfileControllerError extends ProfileControllerState {
  String err;
  ProfileControllerError({required this.err});
}
