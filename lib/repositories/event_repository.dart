import 'package:task_app/networking/api_providor.dart';
import 'package:task_app/models/event.dart';

class EventRepo {
  ApiProvidor _provider = ApiProvidor();

  Future<List<Event>> fetchAll() async {
    final response = await _provider.get('events'); // list, maps, str, int ...

    return List<Event>.from(response.map((e) {
      e['date'] = DateTime.parse(e['date']);
      return Event.fromJson(e);
    }));
  }

//   Future<List<Event>> fetchAll() async {
//     final response = [
//       {
//         "id": 13,
//         "userid": null,
//         "title": "event A",
//         "description": 'facke event',
//         "time": '2021-04-15T00:00:00'
//       },
//       {
//         "id": 20,
//         "userid": null,
//         "title": "event B",
//         "description": 'mock event',
//         "time": '2021-04-16T00:00:00'
//       },
//       {
//         "id": 20,
//         "userid": null,
//         "title": "event C",
//         "description": 'mock event',
//         "time": '2021-04-14T00:00:00'
//       }
//     ];

  // return response.map((e) {
  //   e['time'] = DateTime.parse(e['time']);
  //   return Event.fromJson(e);
  // }).toList();
//   }

}

// test
void main() {
  var list = EventRepo().fetchAll();
  list.then((val) {
    print(val.runtimeType);
    print(val[0]);
    print(val[0].title);
  });
}
