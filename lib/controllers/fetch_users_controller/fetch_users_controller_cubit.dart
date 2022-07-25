import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../models/user_model_group.dart';

part 'fetch_users_controller_state.dart';

class FetchUsersControllerCubit extends Cubit<FetchUsersControllerState> {
  FetchUsersControllerCubit() : super(FetchUsersControllerInitial()){
    fetchAllUsers();
  }
  fetchAllUsers()async
  {
    try{
      List<UserModelGroup> allusers=[];
      String myid=FirebaseAuth.instance.currentUser!.uid;
      emit(FetchUsersControllerLoading());
      var users=await FirebaseFirestore.instance.collection("users").get();
      for(var user in users.docs)
        {
          var data=UserModelGroup.fromRawJson(jsonEncode(user.data()));
          if(data.id!=myid)
            {
              allusers.add(data);
            }
        }
      emit(FetchUsersControllerLoaded(users: allusers));

    }catch(e)
    {
      if(e is SocketException)
        {

        }
      if(e is FirebaseException)
        {

        }
      else
        {

        }
    }

  }
}
