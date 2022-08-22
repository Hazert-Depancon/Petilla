
// class GeneralChatService {
//   final _firestore = FirebaseFirestore.instance;
//   Future<void> sendMessage(String chatName, TextEditingController msg) async {
//     if (msg.text.isNotEmpty) {
//       _firestore.collection("messages").doc("dog_chat").collection("dog_messages").doc().set({
//         "msg": msg.text.trim(),
//         "user": loginUser!.email.toString(),
//         "time": DateTime.now(),
//       });
//       msg.clear();
//     }
//   }
// }
