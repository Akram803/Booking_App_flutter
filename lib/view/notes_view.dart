import 'package:flutter/material.dart';
import 'package:task_app/BLoC/notes_bloc.dart';
import 'package:task_app/models/note.dart';
import 'package:task_app/networking/response.dart';
import 'package:task_app/view/common.dart';


class NotesView extends StatefulWidget {

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {

  NotesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = NotesBloc();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _bloc.fetchNote(),
      child: StreamBuilder<Response<List<Note>>>(
          stream: _bloc.noteListStream,
          builder: (context, snapshot){
            if (snapshot.hasData){  // always has our response obj
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return NotesList(
                    notesList: snapshot.data.data, // list of notes
                    // checkbox: _bloc.checkBox,
                  );
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchNote(),
                  );
                  break;
              }
            }
            return Container(
              child: Center(
                child: Text("Fucken Internal Error"),
              ),
            );
            // return Loading(loadingMessage: 'snapshot.data.message');

          }
      ),
    );
  }
}


class NotesList extends StatelessWidget {

  final List<Note> notesList ;
  const NotesList({Key key, this.notesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final colors = [Colors.yellowAccent, Colors.lightBlueAccent, Colors.lightGreenAccent];

    return ListView.builder(
        itemCount: notesList.length,
        itemBuilder: (BuildContext, indx) =>
            NoteCard(
              color: colors[ indx %3 ],
              note: notesList[indx],
            )
    );
  }
}







// class NotesView extends StatefulWidget {
//
//   @override
//   _NotesViewState createState() => _NotesViewState();
// }
//
// class _NotesViewState extends State<NotesView> {
//
//    List _notes = notes;
//
//   @override
//   Widget build(BuildContext context) {
//
//     global.deleteNote =(note){
//       this.setState(() {
//         _notes.remove(note);
//       });
//     };
//
//     return ListView.builder(
//         itemCount: _notes.length,
//         itemBuilder: (BuildContext, indx) {
//          return NoteCard(
//            color: colors[ indx %3 ],
//            note: _notes[indx],
//            updateParentState: ()=> setState(() {})
//          );
//         }
//     );
//   }
// }

class NoteCard extends StatelessWidget {

  final MaterialAccentColor color ;
  final Note note ; // reference to note data
  NoteCard({Key key, this.color, this.note }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sc_width = MediaQuery.of(context).size.width ;
    return InkWell(
      child: Card(
          color: color, //
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: sc_width*0.05),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: sc_width*0.03, horizontal: sc_width*0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note.title, style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold),),
                SizedBox(
                  height: 5,
                ),
                note.body.length > 200 ?
                    Text( note.body.substring(0,200) )
                        :
                    Text( note.body )
              ],
            ),
          )
      ),
      onTap: (){
        // // / / // / / / / / // / /();
        });

  }
}


// class NoteEditeBialog {
//
//   static  Widget build(buildContext, note, MaterialAccentColor color ) {
//     return Dialog(
//       child: Card(
//           color: color,
//           margin: EdgeInsets.all(0),
//           child: Padding(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                       TextFormField (
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                         ),
//                         initialValue: note['title'],
//                         onChanged: (value) {
//                           note['title'] = value ;
//                         },
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       TextField (
//                         autofocus: false ,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                         ),
//                         minLines: 5,
//                         maxLines: null ,
//                         controller: TextEditingController()..text = note['des'],
//                         onChanged: (value) {
//                           note['des'] = value;
//                         },
//                       )
//                     ],
//                   ),
//                 IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: (){
//                       Navigator.pop(buildContext, 'del' ) ;
//                       global.deleteNote(note);
//                     }),
//               ]
//             ),
//
//
//             ),
//           )
//       );
//   }
// }


