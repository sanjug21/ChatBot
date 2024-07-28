import 'dart:io';

import 'package:chatbot/Common/repo/common_firebase_storage.dart';
import 'package:chatbot/Common/widget/snack_bar.dart';
import 'package:chatbot/Screens/mobile_screen.dart';
import 'package:chatbot/features/auth/screen/otp_screen.dart';
import 'package:chatbot/features/auth/screen/user_info.dart';
import 'package:chatbot/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authRepoProvider=Provider((ref) => AuthRepo(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance));

class AuthRepo{
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepo({required this.auth, required this.firestore});

  Future<UserModel?> getCurrentUserData()async{
    var userData=await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if(userData.data()!=null){
      user=UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber)async{
  try{
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e){throw Exception(e.toString());},
        codeSent: (String verificationId,int? resendToken){
          Navigator.pushNamed(context, OtpScreen.routeName,arguments: verificationId);
        },
        codeAutoRetrievalTimeout:  (String verificationId) {}
    );
  }
   on FirebaseAuthException catch(e){
    showSnackBar(context, e.toString());

  }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP
})async{
    try{
      PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOTP);
  await auth.signInWithCredential(credential);
  Navigator.pushNamedAndRemoveUntil(context, UserInformation.routeName, (route) => false);
    }
    on FirebaseAuthException catch(e){
      showSnackBar(context, e.toString());
    }

  }

  void saveData({required String name, required File? profilePic,required ProviderRef ref,required BuildContext context})async{
  try{
    String uid=auth.currentUser!.uid;
    String photoUrl='';
    if(profilePic!=null){
     photoUrl=await ref.read(commonFirebaseStorageProvider).storeFileToFirebase('profilePic/$uid', profilePic);
    }
    var user=UserModel(name: name, uid: uid, profilePic: photoUrl, isOnline: true, phoneNumber: auth.currentUser!.phoneNumber!, groupId: []);
    await firestore.collection('users').doc(uid).set(user.toMap());
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const MobileScreen()), (route) => false);
  }catch(e){
    showSnackBar(context, e.toString());
  }
  }
  Stream <UserModel> userData(String userId){
    return firestore.collection('users').doc(userId).snapshots().map((event) =>UserModel.fromMap(event.data()!));
  }

}

