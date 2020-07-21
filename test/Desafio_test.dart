import 'package:Desafio/Desafio.dart';
import 'package:test/test.dart';
import 'package:Desafio/models/Request.dart';
import 'package:Desafio/models/User.dart';

void main() {
  Request request;
  User user;

  setUp(() {
    String hash1 = getRandomString(5);
    String hash2 = getRandomString(5);

    user = new User();

    user.username = hash1;
    user.password = hash2;

    request = new Request();
  });
  test('Deve cadastrar um novo usuario na api', () {
    print('user name ' + user.username);
    print('user pass ' + user.password);

    signup(request, user);

    print('Request statusCode ${request.statusCode}');
    print('Request responseJson ${request.responseJson}');

    expect(request.statusCode, 200);
  });
}
