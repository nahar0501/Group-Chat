part of 'create_group_controller_cubit.dart';

@immutable
abstract class CreateGroupControllerState {}

class CreateGroupControllerInitial extends CreateGroupControllerState {}
class CreateGroupControllerCreating extends CreateGroupControllerState {}
class CreateGroupControllerCreate extends CreateGroupControllerState {}
class CreateGroupControllerError extends CreateGroupControllerState {
  String err;
  CreateGroupControllerError({required  this.err});
}
