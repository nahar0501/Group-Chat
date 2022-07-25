part of 'fetch_all_groups_cubit.dart';

@immutable
abstract class FetchAllGroupsState {}

class FetchAllGroupsInitial extends FetchAllGroupsState {}
class FetchAllGroupsLoading extends FetchAllGroupsState {}
class FetchAllGroupsLoaded extends FetchAllGroupsState {
  List<ChatRoomModel> model;
  FetchAllGroupsLoaded({required this.model});
}
class FetchAllGroupsError extends FetchAllGroupsState {
  String err;
  FetchAllGroupsError({required this.err});
}
