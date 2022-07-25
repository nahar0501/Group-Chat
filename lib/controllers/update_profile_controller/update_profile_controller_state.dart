part of 'update_profile_controller_cubit.dart';


abstract class UpdateProfileControllerState {}

class UpdateProfileControllerInitial extends UpdateProfileControllerState {}
class UpdateProfileControllerLoading extends UpdateProfileControllerState {}
class UpdateProfileControllerLoaded extends UpdateProfileControllerState {}
class UpdateProfileControllerError extends UpdateProfileControllerState {
  String err;
  UpdateProfileControllerError({required this.err});
}
