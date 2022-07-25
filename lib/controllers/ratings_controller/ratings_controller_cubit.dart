

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';

part 'ratings_controller_state.dart';

class RatingsControllerCubit extends Cubit<RatingsControllerState> {
  RatingsControllerCubit() : super(RatingsControllerInitial());

  checkMyRating(String id) async {
    try {
      num? rating;
      final ref = await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection("rated")
          .where(FirebaseAuth.instance.currentUser!.uid,isNull: false).snapshots();
      ref.listen((event) {
        if(event.docs.length>0)
          {
            rating=1;
          }
        emit(RatingsControllerLoaded(rating: rating));
      });
    } catch (e) {

    }
  }

  updateRatings(UserModel model,num ratings) async {
    try {
       await FirebaseFirestore.instance
          .collection("users")
          .doc(model.id)
          .update({
        'totalpoints': model.totalpoints + ratings,
        'rated':model.rated+1
      });
       await FirebaseFirestore.instance
           .collection("users")
           .doc(model.id).collection("rated").add({
         FirebaseAuth.instance.currentUser!.uid:ratings,
       });
    } catch (e) {}
  }
}
