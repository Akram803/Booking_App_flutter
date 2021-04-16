

class Task{
  // final int userId;
  final int id;
  String title;
  bool completed;
  Task( {this.id, this.title, this.completed} );

  factory Task.fromJson(Map<String, dynamic> jsonMap) {
    return Task(
        id: jsonMap['id'],
        title: jsonMap['title'],
        completed: jsonMap['completed']
    );
  }

  static List<Task> listFromJson(List jsonList) {
    return jsonList.map((e) => Task.fromJson(e)).toList();
  }

  String toString(){
    return "<Task> _ id: $id , title: $title , completed: $completed";
  }

}

// //test
// void main(){
//   var taskList = Task.listFromJson([
//     {
//       "id": 13,
//       "userid": null,
//       "title": "delectus aut autem",
//       "completed": false,
//       "createdAt": "2021-04-14T00:00:00"
//     },
//     {
//       "id": 20,
//       "userid": null,
//       "title": "delectus aut autem",
//       "completed": false,
//       "createdAt": "2021-04-14T00:00:00"
//     }
//   ]);
//   print(taskList);
// }