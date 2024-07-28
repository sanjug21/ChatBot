import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

 showSnackBar(BuildContext context,String text){
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text(text))
   );

 }

 Future<File?> pickImageFromGallery(BuildContext context)async{
   File? image;
   try{
  final pickedImage=await ImagePicker().pickImage(source: ImageSource.gallery);
  if(pickedImage!=null){
    image=File(pickedImage.path);
  }
   }catch(e){
     // ignore: use_build_context_synchronously
     showSnackBar(context, e.toString());
   }

  return image;
 }