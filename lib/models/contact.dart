//

class Contact {
  // final int userId;
  final int id;
  String name;
  String email;
  String imageUrl;
  Contact({this.id, this.name, this.email, this.imageUrl});

  factory Contact.fromJson(Map<String, dynamic> jsonMap) {
    return Contact(
        id: jsonMap['id'], name: jsonMap['name'], email: jsonMap['mail']);
  }

  static List<Contact> listFromJson(List jsonList) {
    return jsonList.map((e) => Contact.fromJson(e)).toList();
  }

  String toString() {
    return "<Contact> _ id: $id , name: $name , email: $email";
  }
}

// //test
// void main(){
//   var List = Contact.listFromJson([
//     {
//       "id": 1,
//       "name": "Leanne Graham",
//       "username": "Bret",
//       "email": "Sincere@april.biz",
//       "address": {
//         "street": "Kulas Light",
//         "suite": "Apt. 556",
//         "city": "Gwenborough",
//         "zipcode": "92998-3874",
//         "geo": {
//           "lat": "-37.3159",
//           "lng": "81.1496"
//         }
//       },
//       "phone": "1-770-736-8031 x56442",
//       "website": "hildegard.org",
//       "company": {
//         "name": "Romaguera-Crona",
//         "catchPhrase": "Multi-layered client-server neural-net",
//         "bs": "harness real-time e-markets"
//       }
//     },
//     {
//       "id": 2,
//       "name": "Ervin Howell",
//       "username": "Antonette",
//       "email": "Shanna@melissa.tv",
//       "address": {
//         "street": "Victor Plains",
//         "suite": "Suite 879",
//         "city": "Wisokyburgh",
//         "zipcode": "90566-7771",
//         "geo": {
//           "lat": "-43.9509",
//           "lng": "-34.4618"
//         }
//       },
//       "phone": "010-692-6593 x09125",
//       "website": "anastasia.net",
//       "company": {
//         "name": "Deckow-Crist",
//         "catchPhrase": "Proactive didactic contingency",
//         "bs": "synergize scalable supply-chains"
//       }
//     },
//   ]);
//   print(List);
// }
