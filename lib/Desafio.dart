import 'dart:convert' as convert;
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:Desafio/models/Request.dart';
import 'package:Desafio/models/Account.dart';

const API_URL = 'http://localhost:3090';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

/**
 * Sign Up
 */
void signup(Request request) async {
  var body = convert.jsonEncode(
      {'username': request.user.username, 'password': request.user.password});

  String url = API_URL + '/api/signup';
  var response = await http.post(url, body: body, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  });

  request.statusCode = response.statusCode;
  request.responseJson = convert.jsonDecode(response.body);
  request.token = request.responseJson['token'];

  // print("Response status: ${response.statusCode}");
  // print("Response contentLength: ${response.contentLength}");
  // print(response.headers);
  // print(response.request);

  print('User name ${request.user.username}');
  print('User password ${request.user.password}');
  print('Request statusCode ${request.statusCode}');
  print('Request responseJson ${request.responseJson}');
}

/**
 * Sign In
 */
void signin(Request request) async {
  var body = convert.jsonEncode(
      {'username': request.user.username, 'password': request.user.password});

  var url = API_URL + '/api/signin';
  var response = await http.post(url, body: body, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + request.token
  });

  request.statusCode = response.statusCode;
  request.responseJson = convert.jsonDecode(response.body);

  print('User name ${request.user.username}');
  print('User password ${request.user.password}');
  print('Request statusCode ${request.statusCode}');
  print('Request responseJson ${request.responseJson}');
}

/**
 * Get Accounts
 */
Future<List> getAccounts(Request request) async {
  String url = API_URL + '/api/accounts';
  var response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + request.token
  });

  List<dynamic> allData = convert.jsonDecode(response.body);

  List<Account> accounts = new List();

  if (allData.length == 0) {
    return accounts;
  }

  allData.forEach((accountItem) {
    Account account = new Account();
    account.id = accountItem['id'];
    account.agency = accountItem['agencia'];
    account.account = accountItem['conta'];
    account.name = accountItem['name'];
    account.balance = accountItem['balance'];
    accounts.add(account);
  });

  return accounts;
}
