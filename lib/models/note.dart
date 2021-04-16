

class Note{
  // final int userId;
  final int id;
  String title;
  String body;
  Note( {this.id, this.title, this.body} );

  factory Note.fromJson(Map<String, dynamic> jsonMap) {
    return Note(
        id: jsonMap['id'],
        title: jsonMap['title'],
        body: jsonMap['body']
    );
  }

  static List<Note> listFromJson(List jsonList) {
    return jsonList.map((e) => Note.fromJson(e)).toList();
  }

  String toString(){
    return "<Note> _ id: $id , title: $title , body: $body";
  }


}

// //test
// void main(){
//   var List = Note.listFromJson([
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
//   print(List);
// }