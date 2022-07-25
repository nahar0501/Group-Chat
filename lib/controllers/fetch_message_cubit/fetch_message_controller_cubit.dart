import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/msg_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'fetch_message_controller_state.dart';

class FetchMessageControllerCubit extends Cubit<FetchMessageControllerState> {
  FetchMessageControllerCubit() : super(FetchMessageControllerInitial()){
    fetchMessages();
  }
  fetchMessages()async
  {
    List<MsgModel> msgs=[];
    print("triggered");
    try{
      emit(FetchMessageLoadingState());
      final ref=FirebaseFirestore.instance.collection("chats").orderBy("time").snapshots();
      ref.listen((event) {
        msgs.clear();

        for(QueryDocumentSnapshot d in event.docs)
          {
            var model=MsgModel(msgid: d.id,msgBody: MsgBody.fromRawJson(jsonEncode(d.data())));
            msgs.add(model);
          }
        msgs=msgs.reversed.toList();
        emit(FetchMessageNewMessageArrived(msgs: msgs));
        emit(FetchMessageLoadedState(msgs: msgs));
      });
    }catch(e)
    {
      if(e is SocketException)
        {
          emit(FetchMessageErrorState(err:e.message));
        }
      if(e is FirebaseException)
        {
          emit(FetchMessageErrorState(err:e.message.toString()));
        }
    }
  }
  deleteMessage(String id)async
  {
    try{
      print("deleting");
      final ref=FirebaseFirestore.instance.collection("chats").doc(id);
      await ref.delete();
      print("deleted");

    }catch(e)
    {
      print(e.toString());
    }
  }
}
