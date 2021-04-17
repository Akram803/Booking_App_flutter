import 'package:task_app/networking/api_providor.dart';
import 'package:task_app/models/contact.dart';

class ContactRepo {
  ApiProvidor _provider = ApiProvidor();

  Future fetchAll() async {
    final response = await _provider.get('contacts'); // list of maps
    return Contact.listFromJson(response); // list of Task objects
  }
}

// test
// void main(){
//   var list = ContactRepo().fetchAll();
//   list.then((val) {
//     print(val.runtimeType);
//     print(val[0]);
//     print(val[0].name);
//   });
// }
