import 'package:chat_app/controllers/create_group_chat_controller/create_group_controller_cubit.dart';
import 'package:chat_app/controllers/fetch_users_controller/fetch_users_controller_cubit.dart';
import 'package:chat_app/views/all_groups.dart';
import 'package:chat_app/views/custom_widgets/custom_auth_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("users"),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  hintText: "search users",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(style: BorderStyle.none))),
            ),
          ),
          Expanded(
            child: BlocBuilder<FetchUsersControllerCubit,
                FetchUsersControllerState>(
              builder: (context, state) {
                if (state is FetchUsersControllerLoaded) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                          AssetImage("assets/images/invoicebg.jpg"),
                        ),
                        title: Text(state.users[index].name),
                        subtitle: Row(
                          children: [
                            RatingBarIndicator(
                              rating: 2.75,
                              itemBuilder: (context, index) =>
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 10.0,
                              direction: Axis.horizontal,
                            ),
                            const Expanded(
                              child: Text("(${29.5})"),
                            )
                          ],
                        ),
                        trailing: Checkbox(
                          value: state.users[index].isSelected,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onChanged: (bool? selected) {
                            state.users[index].isSelected = selected!;
                            setState(() {});
                          },
                        ),
                      );
                    },
                  );
                }
                if (state is FetchUsersControllerLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FetchUsersControllerError) {
                  return const Center(
                    child: Text("Something went wrong...try again later"),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<FetchUsersControllerCubit, FetchUsersControllerState>(
        builder: (context, state) {
          if(state is FetchUsersControllerLoaded) {
            return BlocListener<
                CreateGroupControllerCubit,
                CreateGroupControllerState>(
              listener: (context, state) {
                // TODO: implement listener
                if(state is CreateGroupControllerCreating)
                  {
                    showDialog(context: context, builder: (context)=>CustomAuthLoading(title: "Creating group"));
                  }
                if(state is CreateGroupControllerCreate)
                  {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_)=>AllGroups()));
                  }
                if(state is CreateGroupControllerError)
                {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.err),backgroundColor: Colors.red,)
                  );
                }
              },
              child: MaterialButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  final _txtName=TextEditingController();
                  showDialog(context: context, builder: (context)=>AlertDialog(
                    content: SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: _txtName,
                              decoration: InputDecoration(
                                hintText: "Group name"
                              ),
                            ),
                          ),
                          MaterialButton(
                            color: Colors.blue,
                            onPressed: (){
                              String creator=FirebaseAuth.instance.currentUser!.uid;
                              List<String> usersIds = [];
                              for(var user in state.users )
                              {
                                if(user.isSelected)
                                {
                                  usersIds.add(user.id);
                                }
                              }
                              usersIds.add(creator);
                              Navigator.pop(context);
                              context.read<CreateGroupControllerCubit>().createGroup(creator, usersIds,_txtName.text);
                              state.users.forEach((user) {
                                user.isSelected=false;
                              });
                            },
                            child: Text("create"),)
                        ],
                      ),
                    ),
                  ));

                },
                child: const Text(
                  "create group",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
          return MaterialButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            onPressed: () {

            },
            child: const Text(
              "create group",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        },
      ),

    );
  }
}
