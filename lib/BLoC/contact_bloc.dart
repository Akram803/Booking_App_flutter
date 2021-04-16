import 'dart:async';
import 'package:task_app/networking/response.dart';
import 'package:task_app/repositories/contact_repository.dart';
import 'package:task_app/models/contact.dart';

class ContactBloc {
  ContactRepo _contactRepo;
  StreamController _contactListcontroller;

  StreamSink<Response<List<Contact>>> get contactListSink =>
      _contactListcontroller.sink;

  Stream<Response<List<Contact>>> get contactListStream =>
      _contactListcontroller.stream;

  ContactBloc() {
    _contactListcontroller = StreamController<Response<List<Contact>>>();
    _contactRepo = ContactRepo();
    fetchContacts();
  }

  fetchContacts() async {
    contactListSink.add(Response.loading('Getting Contacts...'));
    try {
      List<Contact> contact = await _contactRepo.fetchAll();
      contactListSink.add(Response.completed(contact));
    } catch (e) {
      contactListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _contactListcontroller?.close();
  }

}


//test
// void main(){
//   ContactBloc bloc = ContactBloc();
//
//   bloc.contactListStream.listen((event) {
//     print(event.status);
//     print(event.data.runtimeType);
//     if(event.data != null)
//         print(event.data[0]);
//   });
////
// }