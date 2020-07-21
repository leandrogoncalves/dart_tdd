import 'package:Desafio/Desafio.dart';
import 'package:Desafio/models/Request.dart';
import 'package:Desafio/models/User.dart';
import 'package:Desafio/models/Account.dart';
import "package:collection/collection.dart";
import 'dart:mirrors';

getTypeName(dynamic obj) {
  return reflect(obj).type.reflectedType.toString();
}

void main(List<String> arguments) async {
  print('Challange is running');

  String hash1 = getRandomString(5);
  String hash2 = getRandomString(5);
  User user = new User();
  user.username = hash1;
  user.password = hash2;

  Request request = new Request();
  request.user = user;

  print("signup user");
  await signup(request);

  print("signim user");
  await signin(request);

  print("All accounts");
  List<Account> accounts = await getAccounts(request);

  print('Total sum of all deposits in all agencies');
  int totalSum = 0;
  accounts.forEach((account) => {totalSum += account.balance});
  print(totalSum);

  print('Total sum of all deposits in acounts with more than 100 reais');
  int totalAccountsMoreThan100Reais = accounts
      .where((account) {
        return account.balance > 100;
      })
      .toList()
      .length;
  print(totalAccountsMoreThan100Reais);

  print('Number of accounts with balance more than 100 into agency 33');
  List<Account> accountsAgency33 = accounts.where((account) {
    return account.agency == 33;
  }).toList();

  int totalAccountWithMoreThan100 = accountsAgency33
      .where((account) {
        return account.balance > 100;
      })
      .toList()
      .length;
  print(totalAccountWithMoreThan100);

  print('Agency with max balance');

  var accountsGrouped = groupBy(accounts, (account) => account.agency);

  accountsGrouped.forEach((agencyNumber, agencyList) {
    int totalBalance = 0;
    agencyList.forEach((account) => {totalBalance += account.balance});
    print("The balance of agency ${agencyNumber} is ${totalBalance}");
  });
}
