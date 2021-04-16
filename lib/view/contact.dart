import 'package:flutter/material.dart';
import 'package:task_app/BLoC/contact_bloc.dart';
import 'package:task_app/models/contact.dart';
import 'package:task_app/networking/response.dart';
import 'package:task_app/view/common.dart';

class ContactsView extends StatefulWidget {

  @override
  _ContactsViewState createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {

  final ContactBloc _bloc = ContactBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _bloc.fetchContacts(),
      child: StreamBuilder<Response<List<Contact>>>(
          stream: _bloc.contactListStream,
          builder: (context, snapshot){
            if (snapshot.hasData){  // always has our response obj
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return ContactList(
                    contactList: snapshot.data.data,
                  );
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchContacts(),
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

class ContactList extends StatelessWidget {

  final List<Contact> contactList ;
  const ContactList({Key key, this.contactList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for(var contact in contactList)
          ListTile(
            leading: CircleAvatar(
              // child: Icon(Icons.contacts),
              radius: 30.0,
              backgroundImage: NetworkImage("https://lh3.googleusercontent.com/ogw/ADGmqu9eqUjAKTGnvg5WWB95WBsfljkK_MZptp1XO7GE=s32-c-mo"),
              backgroundColor: Colors.transparent,

            ),
            title: Text(contact.name),
            subtitle: Text(contact.email),
          )
      ],
    );
  }
}
