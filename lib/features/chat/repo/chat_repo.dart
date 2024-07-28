
import 'package:chatbot/Common/enum/message_enum.dart';
import 'package:chatbot/Common/widget/snack_bar.dart';
import 'package:chatbot/models/chat_contact.dart';
import 'package:chatbot/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRepoProvider = Provider((ref) => ChatRepo(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepo({required this.firestore, required this.auth});
  void _saveDataToContactSubCollection(
      UserModel senderUserData,
      UserModel receiverUserData,
      String text,
      DateTime timeSent,
      String receiverUserID) async {
    var receiverChatContact = ChatContact(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        lastMessage: text,
        timeSent: timeSent);

    await firestore
        .collection('users')
        .doc(receiverUserID)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(receiverChatContact.toMap());
    var SenderChatContact = ChatContact(
        name: receiverUserData.name,
        profilePic: receiverUserData.profilePic,
        contactId: receiverUserData.uid,
        lastMessage: text,
        timeSent: timeSent);
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserID)
        .set(receiverChatContact.toMap());
  }
  void _saveMessageToMessageSubCollection(
  {
    required String receiverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required String receiverUsername,
    required MessageEnum messageType,
})async{

  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
    required UserModel senderUser,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel receiverUserData;
      var userDataMap =
          await firestore.collection('users').doc(receiverUserId).get();
      receiverUserData = UserModel.fromMap(userDataMap.data()!);
      _saveDataToContactSubCollection(
          senderUser, receiverUserData, text, timeSent, receiverUserId);

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
