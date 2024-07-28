import 'dart:io';

import 'package:chatbot/features/auth/auth_repo.dart';
import 'package:chatbot/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider=Provider((ref)  {
final authRepo=ref.watch(authRepoProvider);
return AuthController(authRepo:authRepo,ref :ref );
});


final userDataAuthProvider=FutureProvider((ref) {
  final authController=ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController{
  final AuthRepo authRepo;
  final ProviderRef ref;
  AuthController({required this.authRepo,required this.ref});

  Future<UserModel?> getUserData()async{
  UserModel? user=await authRepo.getCurrentUserData();
  return user;
  }

  void signInWithPhone(BuildContext context,String phoneNumber){
    authRepo.signInWithPhone(context, phoneNumber);
  }
  void verifyOTP(BuildContext context, String verificationId, String userOTP){
    authRepo.verifyOTP(context: context, verificationId: verificationId, userOTP: userOTP);
  }
  void saveDataToFirebase(BuildContext context,String name , File? profilePic){
  authRepo.saveData(name: name, profilePic: profilePic, ref: ref, context: context);
  }
  Stream<UserModel> userDataById(String userId){
    return authRepo.userData(userId);
  }
}