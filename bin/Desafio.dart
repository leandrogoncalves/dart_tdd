import 'package:Desafio/Desafio.dart';
import 'package:Desafio/models/Request.dart';
import 'package:Desafio/models/User.dart';

void main(List<String> arguments) {
  print('Challange is running');

  String hash1 = getRandomString(5);
  String hash2 = getRandomString(5);

  User user = new User();

  user.username = hash1;
  user.password = hash2;

  Request request = new Request();
  signup(request, user);
}
