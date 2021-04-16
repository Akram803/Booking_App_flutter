import 'package:flutter/material.dart';
import 'package:task_app/BLoC/task_bloc.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/networking/response.dart';
import 'package:task_app/view/common.dart';


class TasksView extends StatefulWidget {

  @override
  _TasksViewState createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {

  TaskBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TaskBloc();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _bloc.fetchTasks(),
      child: StreamBuilder<Response<List<Task>>>(
          stream: _bloc.taskListStream,
          builder: (context, snapshot){
            if (snapshot.hasData){  // always has our response obj
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return TaskList(
                    tasksList: snapshot.data.data,
                    checkbox: _bloc.checkBox,
                  );
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchTasks(),
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


class TaskList extends StatelessWidget {
  final List<Task> tasksList ;
  final Function checkbox ;
  const TaskList({Key key, this.tasksList, this.checkbox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasksList.length,
        itemBuilder: (BuildContext, indx) =>
          TaskWidget(
              tasksList[indx], checkbox
          )
        );
  }
}


class TaskWidget extends StatefulWidget {
  Task data;
  Function(Task task) checkbox;
  TaskWidget(this.data, this.checkbox);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        // secondary: const Icon(Icons.alarm),
        title: Text(widget.data.title),
        // subtitle: Text(data[indx]['des']),
        value: widget.data.completed,
        onChanged: (bool value) {
          widget.checkbox(widget.data);
          setState(() {});
        });
  }
}


