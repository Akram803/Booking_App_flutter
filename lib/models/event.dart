

class Event{
  // final int userId;
  final int id;
  String title;
  String description;
  DateTime time;
  Event({this.id, this.title, this.description, this.time});

  factory Event.fromJson(Map<String, dynamic> jsonMap) {
    return Event(
        id: jsonMap['id'],
        title: jsonMap['title'],
        description: jsonMap['description'],
        time: jsonMap['time']
    );
  }

  static List<Event> listFromJson(List jsonList) {
    return jsonList.map((e) => Event.fromJson(e)).toList();
  }

  String toString(){
    return "<Event> _ id: $id , title: $title , description: $description , time: $time";
  }

}

// //test
// void main(){
//   var list = Event.listFromJson([
//     {
//       "id": 13,
//       "userid": null,
//       "title": "event A",
//       "description": 'facke event',
//       "time": DateTime.utc(2021,4,16,0,0,0)
//     },
//     {
//       "id": 20,
//       "userid": null,
//       "title": "event B",
//       "description": 'mock event',
//       "time": DateTime.utc(2021,4,15,0,0,0)
//     }
//   ]);
//   print(list);
// }