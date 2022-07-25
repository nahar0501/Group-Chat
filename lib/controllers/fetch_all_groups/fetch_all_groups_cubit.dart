import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/controllers/fetch_users_controller/fetch_users_controller_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../models/ChatRoomModel.dart';

part 'fetch_all_groups_state.dart';

class FetchAllGroupsCubit extends Cubit<FetchAllGroupsState> {
  FetchAllGroupsCubit() : super(FetchAllGroupsInitial()){
    fetchAllGroups();
  }
  fetchAllGroups()async
  {
    try{
      List<ChatRoomModel> chatRooms=[];
      String myid=FirebaseAuth.instance.currentUser!.uid;
      emit(FetchAllGroupsLoading());
      var rooms= FirebaseFirestore.instance.collection("chatrooms").where("members",arrayContains: myid).snapshots();
      rooms.listen((event) {
        chatRooms.clear();
        for(var room in event.docs)
          {
            String roomid=room.id;
            var data=ChatRoomData.fromRawJson(jsonEncode(room.data()));
            chatRooms.add(ChatRoomModel(id: roomid, data: data));

          }
        emit(FetchAllGroupsLoaded(model: chatRooms));
      });


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
