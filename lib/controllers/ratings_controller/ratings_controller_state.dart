part of 'ratings_controller_cubit.dart';

@immutable
abstract class RatingsControllerState {}

class RatingsControllerInitial extends RatingsControllerState {}
class RatingsControllerLoading extends RatingsControllerState {}
class RatingsControllerLoaded extends RatingsControllerState {
  num? rating;
  RatingsControllerLoaded({required this.rating});
}
class RatingsControllerError extends RatingsControllerState {
  String err;
  RatingsControllerError({required this.err});
}
