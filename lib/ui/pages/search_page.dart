import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:social_media_app/app/configs/colors.dart';
import 'package:social_media_app/ui/pages/inbox_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  Map<String,dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else{
      return "$user2$user1";
    }
  }

  void onSearch() async{

    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });

    await fireStore.collection('users').where("email", isEqualTo: _search.text).get().then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor2,
      body: isLoading? Center(
        child: Container(
          height: 50,
          width: 50,
          child: const CircularProgressIndicator(
          ),
        ),
      ):Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            height: 50,
            width: 500,
            child: TextField(
              controller: _search,
              decoration: InputDecoration(
                hintText: "Search User",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(onPressed: onSearch, child: Text("Search")),
          const SizedBox(
            height: 30,
          ),
          userMap != null ? ListTile(
            onTap: (){

              String roomId = chatRoomId(_auth.currentUser!.uid, userMap?['email']);

              Navigator.of(context).push(MaterialPageRoute(builder: (_) => InboxPage(
                chatRoomId: roomId,userMap: userMap,
              )));

            },
            leading: const Icon(Icons.account_box, color: Colors.white,),
            title: Text(userMap?['email'],style: const TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold,
            ),),
            trailing: const Icon(Icons.chat, color: Colors.white),
          ): Container(),

        ],
      ),
    );
  }
}
