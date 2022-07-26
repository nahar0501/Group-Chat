import 'package:chat_app/views/custom_widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/fetch_all_groups/fetch_all_groups_cubit.dart';
import 'all_users.dart';
import 'chat_screen.dart';

class AllGroups extends StatefulWidget {
  const AllGroups({Key? key}) : super(key: key);

  @override
  State<AllGroups> createState() => _AllGroupsState();
}

class _AllGroupsState extends State<AllGroups> {
  String _searchText="";
  final _txtSearch=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Groups"),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextField(
              onChanged: (String value){
                _searchText=value;
                print(value);
                print("changed");
                setState(() {

                });
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  hintText: "search groups",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(style: BorderStyle.none))),
            ),
          ),
          Expanded(
            child: BlocConsumer<FetchAllGroupsCubit, FetchAllGroupsState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if(state is FetchAllGroupsLoaded) {
                  return ListView.builder(
                    itemCount: state.model.length,
                    itemBuilder: (context, index) {
                      return state.model[index].data.name.toLowerCase().startsWith(_searchText.toLowerCase())  ? ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatScreen(chatRoomModel: state.model[index],)));
                        },
                        leading:const CircleAvatar(
                          backgroundImage:
                          AssetImage("assets/images/invoicebg.jpg"),
                        ),
                        title: Text(
                          state.model[index].data.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${state.model[index].data.members.length} members",
                          style: TextStyle(fontSize: 10),
                        ),
                      ):const SizedBox();
                    },
                  );
                }
                if(state is FetchAllGroupsLoading)
                  {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                if(state is FetchAllGroupsError)
                  {
                    return  Center(
                      child: Text(state.err),
                    );
                  }
                return Container();
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AllUsers()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
