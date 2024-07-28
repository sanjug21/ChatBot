import 'dart:io';

import 'package:chatbot/Common/widget/snack_bar.dart';
import 'package:chatbot/features/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInformation extends ConsumerStatefulWidget {
 static const routeName='/user-info';
  const UserInformation({super.key});

  @override
  ConsumerState<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends ConsumerState<UserInformation> {
  final TextEditingController nameContoller=TextEditingController();
  File? image;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameContoller.dispose();
  }
  void selectImage()async{
  image=await pickImageFromGallery(context);
  setState(() {
  });
  }
  void storeUserData()async{
    String name=nameContoller.text.trim();
    if(name.isNotEmpty){
      ref.read(authControllerProvider).saveDataToFirebase(context, name, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return  Scaffold(
      body: SafeArea(child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                image ==null? const CircleAvatar(
                  backgroundImage: AssetImage("prof.jpeg"),
                  radius: 64,
                ):CircleAvatar(
                  backgroundImage: FileImage(image!),
                  radius: 64,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                      onPressed: selectImage,
                      icon:const Icon(Icons.add_a_photo)),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: size.width*0.85,
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: nameContoller,
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Name'
                    ),
                  ),
                ),
                IconButton(onPressed: storeUserData, icon:const  Icon(Icons.done))
              ],
            )
          ],
        ),
      ))
    );
  }
}
