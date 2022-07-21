import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'timer_controller_state.dart';

class TimerControllerCubit extends Cubit<int> {
  TimerControllerCubit() : super(60);

  startTimer()
  {
    int sec=60;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(sec<1){
        emit(sec);
        timer.cancel();
      }
      else
        {
          emit(sec);
          sec-=1;
        }
    });
  }
}
