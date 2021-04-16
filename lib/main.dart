import 'package:flutter/material.dart';

import 'package:task_app/view/notes_view.dart';
import 'package:task_app/view/tasks_view.dart';
import 'package:task_app/view/contact.dart';
import 'package:task_app/view/appointment_view.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text("BOOK"),
            // bottom: ,
          ),
          bottomNavigationBar: TabBar(
            labelColor: Colors.deepPurple,
            tabs: [
              Tab(icon: Icon(Icons.calendar_today), text: "Appointments") ,
              Tab(icon: Icon(Icons.contacts), text: "Contacts") ,
              Tab(icon: Icon(Icons.note_sharp), text: "Notes") ,
              Tab(icon: Icon(Icons.check_box), text: "Tasks") ,
            ],
          ),
          body: TabBarView(
            children: [
              AppointmentView(),
              ContactsView(),
              NotesView(),
              TasksView(),
            ],
          ),

          floatingActionButton: FloatingActionButton(
            tooltip: "add",
            child: Icon(Icons.add),
            onPressed: (){},
          ),
        ),
      ),
    );
  }
}








