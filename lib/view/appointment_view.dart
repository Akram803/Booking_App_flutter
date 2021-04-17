import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:task_app/models/event.dart';
import 'package:task_app/BLoC/event_bloc.dart';
import 'package:task_app/networking/response.dart';
import 'package:task_app/view/common.dart';

import 'package:task_app/view/common.dart';

EventBloc _bloc; //= EventBloc();

class AppointmentView extends StatefulWidget {
  @override
  _AppointmentViewState createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  @override
  void initState() {
    super.initState();
    _bloc = EventBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Response<List<Event>>>(
        stream: _bloc.eventListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // always has our response obj
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                return CalendarView();
                break;
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () => _bloc.fetchEvents(),
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
        });
  }
}

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  // late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  DateTime _rangeStart;
  DateTime _rangeEnd;

  DateFormat _format = DateFormat('y, M / d');

  List<Event> _selectedEvents;

  List<Event> _getEventsForDay(DateTime date) {
    String key = "${date.year}${date.month}${date.day}";
    return _bloc.events[key] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2021, 01, 01),
      lastDay: DateTime.utc(2021, 12, 30),
      focusedDay: _focusedDay,

      selectedDayPredicate: (day) {
        //for each day in calendar
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
          _selectedDay = selectedDay;
          _selectedEvents = _getEventsForDay(selectedDay);
          print("move");
          //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ListView(
                // height: MediaQuery.of(context).size.height,
                // color: Colors.amber,
                padding: EdgeInsets.all(10),
                children: [
                  ListTile(
                    title: Text(_format.format(_selectedDay)),
                  ),
                  for (var ev in _selectedEvents)
                    ListTile(
                      title: Text(ev.title),
                      subtitle: Text(ev.date.toString()),
                      tileColor: Colors.black12,
                    )
                ],
              );
            },
          );
        });
      },

      calendarFormat: _calendarFormat,

      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      //
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },

      eventLoader: (day) {
        // for each day in
        return _getEventsForDay(day); // my defined func
      },
    );
  }
}
