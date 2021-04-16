

import 'package:task_app/networking/api_providor.dart';
import 'package:task_app/models/task.dart';

class TaskRepo{
  ApiProvidor _provider = ApiProvidor();

  Future fetchAll() async {
    final response = await _provider.get('todos'); // list of maps
    return Task.listFromJson(response); // list of Task objects
  }
}


// test
// void main(){
//   var list = TaskRepo().fetchAll();
//   list.then((val) {
//     print(val.runtimeType);
//     print(val[0]);
//     print(val[0].id);
//   });
// }