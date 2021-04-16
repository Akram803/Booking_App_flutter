import 'dart:async';
import 'package:task_app/models/note.dart';
import 'package:task_app/networking/response.dart';
import 'package:task_app/repositories/notes_repository.dart';

class NotesBloc {
  NotesRepo _noteRepo;
  StreamController _NoteListStreamController;
 
  StreamSink<Response<List<Note>>> get noteListSink =>
      _NoteListStreamController.sink;

  Stream<Response<List<Note>>> get noteListStream =>
      _NoteListStreamController.stream;

  NotesBloc() {
    _NoteListStreamController = StreamController<Response<List<Note>>>();
    _noteRepo = NotesRepo();
    fetchNote();
  }

  fetchNote() async {
    noteListSink.add(Response.loading('Getting Notes.'));
    try {
      List<Note> notes = await _noteRepo.fetchAll();
      noteListSink.add(Response.completed(notes));
    } catch (e) {
      noteListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _NoteListStreamController?.close();
  }

}


//test
// void main(){
//   NotesBloc bloc = NotesBloc();
//
//   bloc.noteListStream.listen((respo) {
//     print(event.status);
//     print(event.data.runtimeType);
//     if(event.data != null)
//         print(event.data[0]);
//   });
//
// }