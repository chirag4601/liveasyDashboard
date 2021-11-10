import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:liveasy_admin/functions/accessingurl.dart' as ac;

Future runPutDocumentApi(
    {required Map toBeUpdated, required String userId}) async {
  List<String> li = await Future.wait<String>([
    ac.getdocumenturl(),
  ]);
  final String apiUrl = li[0];
  final String additionalQuery = '/';
  String body = json.encode(toBeUpdated);
  final http.Response response = await http.put(
      Uri.parse("$apiUrl$additionalQuery$userId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: body);
  if (response.statusCode == 200) {
    var decodedResponse = json.decode(response.body);
    print(decodedResponse);
    return "Success";
  } else {
    return "Error";
  }
}
