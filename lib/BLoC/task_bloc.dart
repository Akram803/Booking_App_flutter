import 'dart:async';
import 'package:task_app/networking/response.dart';
import 'package:task_app/repositories/task_repository.dart';
import 'package:task_app/models/task.dart';

class TaskBloc {
  TaskRepo _taskRepo;
  StreamController _taskListcontroller;

  StreamSink<Response<List<Task>>> get taskListSink =>
      _taskListcontroller.sink;

  Stream<Response<List<Task>>> get taskListStream =>
      _taskListcontroller.stream;

  TaskBloc() {
    _taskListcontroller = StreamController<Response<List<Task>>>();
    _taskRepo = TaskRepo();
    fetchTasks();
  }

  fetchTasks() async {
    taskListSink.add(Response.loading('Getting Tasks.'));
    try {
      List<Task> tasks = await _taskRepo.fetchAll();
      taskListSink.add(Response.completed(tasks));
    } catch (e) {
      taskListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  checkBox(Task task){
    task.completed = !task.completed;
  }

  dispose() {
    _taskListcontroller?.close();
  }

}


//test
// void main(){
//   TaskBloc bloc = TaskBloc();
//
//   bloc.taskListStream.listen((event) {
//     print(event.status);
//     print(event.data.runtimeType);
//     if(event.data != null)
//         print(event.data[0]);
//   });
//
//
// }