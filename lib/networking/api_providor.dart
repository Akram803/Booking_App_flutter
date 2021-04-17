
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;


class ApiProvidor{
  final String _baseUrl = "https://localhost:5001/api/";
  // final String _baseUrl = "jsonplaceholder.typicode.com";

  Future<dynamic> get(String path) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + path));
      responseJson = _response(response); // structure list&map
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    print(response);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // print(responseJson);
        return responseJson;
      default:
        Exception('Error occured while Communication with Server with StatusCode : ${response.statusCode}');

    }
  }
}



//test
// void main() {
//   final jsonResponse = ApiProvidor().get('todos');
//   jsonResponse.then((value) => print(value));
//   // print(Uri.parse("https://localhost:5001/api/Todos"));
// }
