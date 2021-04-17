import 'package:task_app/models/note.dart';
import 'package:task_app/networking/api_providor.dart';

class NotesRepo {
  ApiProvidor _provider = ApiProvidor();

  Future fetchAll() async {
    final response = await _provider.get('notes'); // list of maps
    return Note.listFromJson(response); // list of Task objects
  }
}

// test
// void main(){
//   var list = NotesRepo().fetchAll();
//   list.then((val) {
//     print(val.runtimeType);
//     print(val[0]);
//   });
// }
