import 'package:chatbot/Common/widget/snack_bar.dart';
import 'package:chatbot/features/chat/chat_screens/mobile_chat_screen.dart';
import 'package:chatbot/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectContactRepoProvider =
    Provider((ref) => SelectContactRepo(firestore: FirebaseFirestore.instance));

class SelectContactRepo {
  final FirebaseFirestore firestore;

  SelectContactRepo({required this.firestore});
  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectContact,BuildContext context)async{
    try{
      var userCollectin=await firestore.collection('users').get();
      bool isFind=false;
      for(var document in userCollectin.docs){
        var userData=UserModel.fromMap(document.data());
        String selectPhoneNum=selectContact.phones[0].number.replaceAll(' ', '');
        if(selectPhoneNum==userData.phoneNumber){
          isFind=true;
          Navigator.pushNamed(context, MobileChatScreen.routeName,arguments: {'name':userData.name,'uid':userData.uid});
        }
        print(selectContact.phones[0].number);
      }
      if(!isFind)showSnackBar(context, 'This number does not exist');
    }
    catch(e){
      showSnackBar(context, e.toString());
    }
  }
}

