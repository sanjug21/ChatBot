import 'package:chatbot/features/selectcontacts/repo/select_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getContactProvider=FutureProvider((ref) {
  final selectContactRepo=ref.watch(selectContactRepoProvider);
  return selectContactRepo.getContacts();
});

final selectContactControllerProvider=Provider((ref) {
  final selectContactRepo=ref.watch(selectContactRepoProvider);
  return SelectContactController(ref: ref, selectContactRepo: selectContactRepo);
}

);

class SelectContactController{
  final ProviderRef ref;
  final SelectContactRepo selectContactRepo;

  SelectContactController({required this.ref, required this.selectContactRepo});
  void selectContact(Contact selectedContact,BuildContext context)async{
    selectContactRepo.selectContact(selectedContact, context);
  }

}