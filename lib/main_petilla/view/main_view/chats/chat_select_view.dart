// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:petilla_app_project/view/theme/light_theme_colors.dart';

// var loginUser = FirebaseAuth.instance.currentUser;

// class ChatSelectView extends StatefulWidget {
//   const ChatSelectView({Key? key}) : super(key: key);

//   @override
//   State<ChatSelectView> createState() => _ChatSelectViewState();
// }

// class _ChatSelectViewState extends State<ChatSelectView> {
//   final auth = FirebaseAuth.instance;
//   TextEditingController msg = TextEditingController();
//   final _firestore = FirebaseFirestore.instance;

//   getCurrentUser() {
//     final user = auth.currentUser;
//     if (user != null) {
//       loginUser = user;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(loginUser!.email.toString()),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const Expanded(child: ShowMessages()),
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: msg,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Send a message',
//                   ),
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   if (msg.text.isNotEmpty) {
//                     _firestore.collection("messages").doc().set({
//                       "msg": msg.text.trim(),
//                       "user": loginUser!.email.toString(),
//                       "time": DateTime.now(),
//                     });
//                     msg.clear();
//                   }
//                 },
//                 icon: const Icon(Icons.send),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ShowMessages extends StatelessWidget {
//   const ShowMessages({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection("messages").orderBy("time").snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//             reverse: false,
//             shrinkWrap: true,
//             primary: true,
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               QueryDocumentSnapshot querySnapshot = snapshot.data!.docs[index];
//               return ListTile(
//                 title: Column(
//                   crossAxisAlignment:
//                       loginUser!.email == querySnapshot["user"] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(querySnapshot["user"]),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: loginUser!.email == querySnapshot["user"]
//                                 ? LightThemeColors.miamiMarmalade.withOpacity(0.6)
//                                 : LightThemeColors.snowbank,
//                             borderRadius: loginUser!.email == querySnapshot["user"]
//                                 ? const BorderRadius.only(
//                                     topLeft: Radius.circular(55),
//                                     topRight: Radius.circular(55),
//                                     bottomLeft: Radius.circular(55),
//                                   )
//                                 : const BorderRadius.only(
//                                     topLeft: Radius.circular(55),
//                                     topRight: Radius.circular(55),
//                                     bottomRight: Radius.circular(55),
//                                   ),
//                           ),
//                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                           child: Column(
//                             children: [
//                               Text(querySnapshot["msg"]),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/main_petilla/view/main_view/chats/in_chat_view.dart';
import 'package:petilla_app_project/main_petilla/view/widgets/chat_widgets/user_chat.dart';
import 'package:petilla_app_project/theme/strings/project_lottie_urls.dart';

class ChatSelectView extends StatefulWidget {
  const ChatSelectView({Key? key}) : super(key: key);

  @override
  State<ChatSelectView> createState() => _ChatSelectViewState();
}

class _ChatSelectViewState extends State<ChatSelectView> {
  void callInChat(String friendEmail, String friendUid, String currentEmail, String currentUid) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InChatView(
          currentUserId: currentUid,
          currentUserEmail: currentEmail,
          friendUserId: friendUid,
          friendUserEmail: friendEmail,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("messages")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    const Text("Henüz kimseyle mesajlaşmadınız", style: TextStyle(fontSize: 20)),
                    Center(child: Lottie.network(ProjectLottieUrls.emptyLottie)),
                  ],
                ),
              );
            } else {
              ListView.builder(
                itemBuilder: (context, index) {
                  return UserChat(
                    name: snapshot.data!.docs[index]["email"],
                    onTap: () {
                      callInChat(
                        snapshot.data!.docs[index]["email"],
                        snapshot.data!.docs[index]["uid"],
                        FirebaseAuth.instance.currentUser!.email.toString(),
                        FirebaseAuth.instance.currentUser!.uid,
                      );
                    },
                  );
                },
              );
            }
          }
          if (snapshot.hasError) {
            return Center(child: Lottie.network(ProjectLottieUrls.errorLottie));
          }
          return Center(child: Lottie.network(ProjectLottieUrls.loadingLottie));
        },
      ),
    );
  }
}
