part of 'fetch_users_controller_cubit.dart';


abstract class FetchUsersControllerState {}

class FetchUsersControllerInitial extends FetchUsersControllerState {}
class FetchUsersControllerLoading extends FetchUsersControllerState {}
class FetchUsersControllerLoaded extends FetchUsersControllerState {
 List<UserModelGroup> users;
 FetchUsersControllerLoaded({required  this.users});
}
class FetchUsersControllerError extends FetchUsersControllerState {
  String err;
  FetchUsersControllerError({required this.err});
}
