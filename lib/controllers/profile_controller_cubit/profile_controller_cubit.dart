import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:meta/meta.dart';

import '../../shared_prefs/Prefs.dart';

part 'profile_controller_state.dart';

class ProfileControllerCubit extends Cubit<ProfileControllerState> {
  ProfileControllerCubit() : super(ProfileControllerInitial()){
    loadUserData();
  }
  loadUserData()async
  {
    emit(ProfileControllerLoading());
    UserModel? data=await Prefs.getUserData();
    emit(ProfileControllerLoaded(userModel: data!));
  }
}
