import 'package:chatbot/Common/widget/error.dart';
import 'package:chatbot/Common/widget/loader.dart';
import 'package:chatbot/features/selectcontacts/controller/select_contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SelectContactScreen extends ConsumerWidget {
  static const routeName='/select-contact';
  const SelectContactScreen({super.key});


  void selectContact(WidgetRef ref ,Contact selectedContact,BuildContext context){
    ref.read(selectContactControllerProvider).selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contact"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: ref.watch(getContactProvider).when(data: (contactList)=>ListView.builder(
        itemCount: contactList.length,
          itemBuilder:(context,index){
          final contact=contactList[index];
          return InkWell(
            onTap: ()=>selectContact(ref,contact,context),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(contact.displayName,style: const TextStyle(fontSize: 18),),
                leading: contact.photo==null?null:CircleAvatar(
                  backgroundImage: MemoryImage(contact.photo!),
                  radius: 30,
                ),
              ),
            ),
          );
          })
          , error:(err,trace)=>ErrorScreen(error: err.toString()), loading: ()=> const Loader()),
    );
  }
}
