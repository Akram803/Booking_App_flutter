import 'dart:async';
import 'package:task_app/models/event.dart';
import 'package:task_app/networking/response.dart';
import 'package:task_app/repositories/event_repository.dart';

class EventBloc {

  final Map<String , List<Event>>  events = new Map<String , List<Event>>();

  EventRepo _eventRepo;
  StreamController _eventListStreamController;

  StreamSink<Response<List<Event>>> get eventListSink =>
      _eventListStreamController.sink;

  Stream<Response<List<Event>>> get eventListStream =>
      _eventListStreamController.stream;

  EventBloc() {
    _eventListStreamController = StreamController<Response<List<Event>>>();
    _eventRepo = EventRepo();
    // events =
    fetchEvents();
  }

  Future<List<Event>> fetchEvents() async {
    eventListSink.add(Response.loading('Getting Contacts...'));
      try {
        List<Event> eventList = await _eventRepo.fetchFackEvents();
        constructEvs(eventList);
        eventListSink.add(Response.completed(eventList));
      } catch (e) {
        eventListSink.add(Response.error(e.toString()));
        print(e);
      }
    }

    constructEvs(List<Event> li){
      String key;
      li.forEach((ev) {
        key = "${ev.time.year}${ev.time.month}${ev.time.day}";
        if(events[key] == null)
            events[key] = [];
        events[key].add(ev);
      });
    }

  dispose() {
    _eventListStreamController?.close();
  }

}


//test
// void main(){
//   EventBloc bloc = EventBloc();
//
//   bloc.eventListStream.listen((respo) {
//     print(respo.status);
//     print(respo.data.runtimeType);
//     if(respo.data != null) {
//       print(respo.data.length);
//       print(respo.data[0].toString());
//     }
//   });
//
// }