
import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/models/ChatRoomModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/fetch_message_cubit/fetch_message_controller_cubit.dart';
import '../controllers/send_message_cubit/send_message_controller_cubit.dart';
import 'custom_widgets/reciever_ui.dart';
import 'custom_widgets/sender_ui.dart';

class ChatScreen extends StatefulWidget {
  ChatRoomModel chatRoomModel;
  ChatScreen({required this.chatRoomModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final txtMsg = TextEditingController();

  var msgsCotroller=ScrollController();

  @override
  void initState(){
    super.initState();
    context.read<FetchMessageControllerCubit>().fetchMessages(widget.chatRoomModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        title:  Text(
          widget.chatRoomModel.data.name,
          style: TextStyle(color: Colors.white),
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

                      if (state.msgs[index].msgBody.sender == myId) {
                        if(state.msgs[index].msgBody.type==1)
                          {
                            return Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 100,
                                margin: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width*0.4,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.amber.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      state.msgs[index].msgBody.msg
                                    )
                                  )
                                ),
                              ),
                            );
                          }
                        return InkWell(
                          onLongPress: (){
                            showDialog(context: context, builder: (context)=> AlertDialog(
                              content:const  SizedBox(
                                height: 70,
                                child: Text("Do you want to delete this message"),
                              ),
                              actions: [
                                IconButton(onPressed: (){
                                  context.read<FetchMessageControllerCubit>().deleteMessage(state.msgs[index].msgid);
                                  Navigator.pop(context);
                                }, icon: Icon(Icons.delete)),
                                IconButton(onPressed: (){
                                  Navigator.pop(context);
                                }, icon: Icon(Icons.cancel))
                              ],
                            ));

                          },
                            child: SenderUI(msg: state.msgs[index].msgBody.msg));
                      }
                      if(state.msgs[index].msgBody.type==1)
                      {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 100,
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width*0.4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.cyan.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        state.msgs[index].msgBody.msg
                                    )
                                )
                            ),
                          ),
                        );
                      }
                      return RecieverUI(
                        ph: state.msgs[index].msgBody.name,
                        msg: state.msgs[index].msgBody.msg,
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
            height: 70,
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
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: txtMsg,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        prefixIcon: IconButton(
                          onPressed: (){
                            showModalBottomSheet(context: context,
                                builder: (_)=>Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: GridView.builder(
                                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20),
                                      itemCount: stickers.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return InkWell(
                                          onTap: (){
                                            context.read<SendMessageControllerCubit>().sendMessage(
                                                msg: stickers[index],
                                                type: 1,
                                                chatRoomModel: widget.chatRoomModel
                                            );
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.amber,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    app_sticker[index]
                                                  )
                                                ),
                                                borderRadius: BorderRadius.circular(15)),
                                          ),
                                        );
                                      }),
                                ),
                            );
                          },
                          icon: Icon(Icons.add_circle,color: Colors.black,),
                        ),
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
                              type: 0,
                              chatRoomModel: widget.chatRoomModel
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
