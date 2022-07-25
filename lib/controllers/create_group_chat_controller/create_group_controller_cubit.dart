import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'create_group_controller_state.dart';

class CreateGroupControllerCubit extends Cubit<CreateGroupControllerState> {
  CreateGroupControllerCubit() : super(CreateGroupControllerInitial());

  createGroup(String creator,List<String> users,String name)async
  {
    try{
      emit(CreateGroupControllerCreating());
      await FirebaseFirestore.instance.collection("chatrooms").add({
       "members":users,
        "creator":creator,
        'name':name
      });
      emit(CreateGroupControllerCreate());
    }catch(e)
    {

    }
  }
}
