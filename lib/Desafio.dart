import 'dart:convert' as convert;
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:Desafio/models/User.dart';
import 'package:Desafio/models/Request.dart';

const API_URL = 'http://localhost:3090';

void signup(Request request, User user) async {
  var body = convert
      .jsonEncode({'username': user.username, 'password': user.password});

  var url = API_URL + '/api/signup';
  var response = await http.post(url, body: body, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  });

  request.statusCode = response.statusCode;
  request.responseJson = convert.jsonDecode(response.body);

  // print("Response status: ${response.statusCode}");
  // print("Response contentLength: ${response.contentLength}");
  // print(response.headers);
  // print(response.request);

  print('User name ${user.username}');
  print('User password ${user.password}');
  print('Request statusCode ${request.statusCode}');
  print('Request responseJson ${request.responseJson}');
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
