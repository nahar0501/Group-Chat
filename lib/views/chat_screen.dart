import 'package:chat_app/controllers/fetch_message_cubit/fetch_message_controller_cubit.dart';
import 'package:chat_app/controllers/fetch_message_cubit/fetch_message_controller_cubit.dart';
import 'package:chat_app/controllers/send_message_cubit/send_message_controller_cubit.dart';
import 'package:chat_app/views/custom_widgets/reciever_ui.dart';
import 'package:chat_app/views/custom_widgets/sender_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  final txtMsg = TextEditingController();
  var msgsCotroller=ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        title: const Text(
          "Group Chat",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: BlocConsumer<FetchMessageControllerCubit,
                FetchMessageControllerState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is FetchMessageLoadingState) {
                  print("Loading messages");
                }
                if (state is FetchMessageLoadedState) {
                  print("msgs fetched");
                }
                if (state is FetchMessageErrorState) {
                  print(state.err);
                }
              },
              builder: (context, state) {
                if (state is FetchMessageLoadedState) {
                  return ListView.builder(
                    reverse: true,
                    controller: msgsCotroller,
                    itemCount: state.msgs.length,
                    itemBuilder: (context, index) {
                      String myId = FirebaseAuth.instance.currentUser!.uid;

                      if (state.msgs[index].sender == myId) {
                        return SenderUI(msg: state.msgs[index].msg);
                      }
                      return RecieverUI(
                        ph: state.msgs[index].ph,
                        msg: state.msgs[index].msg,
                      );
                    },
                  );
                }
                if (state is FetchMessageLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              ),
                color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 3,
              )
            ]),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: txtMsg,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                BlocListener<SendMessageControllerCubit,
                    SendMessageControllerState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is SendingState) {
                      print("sending...");
                    }
                    if (state is SentState) {
                      print("sent success");
                      txtMsg.clear();
                    }
                    if (state is FailureState) {
                      print(state.err);
                    }
                  },
                  child: IconButton(
                      onPressed: () {
                        if(txtMsg.text.isNotEmpty)
                          {
                            context.read<SendMessageControllerCubit>().sendMessage(
                              msg: txtMsg.text,
                            );
                          }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
