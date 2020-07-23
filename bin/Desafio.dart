import 'package:Desafio/Desafio.dart';
import 'package:Desafio/models/Request.dart';
import 'package:Desafio/models/User.dart';
import 'package:Desafio/models/Account.dart';
import "package:collection/collection.dart";
import 'dart:mirrors';

getTypeName(dynamic obj) {
  return reflect(obj).type.reflectedType.toString();
}

void printNewLine(var value) {
  print(' ');
  print(value);
  print(' ');
}

void print_r(var someValue) {
  String someValueType = someValue.runtimeType.toString();
  String someValueString = someValue.toString();
  print(someValueType + ':  ' + someValueString);
}

void main(List<String> arguments) async {
  printNewLine('Challange is running');

  String hash1 = getRandomString(5);
  String hash2 = getRandomString(5);
  User user = new User();
  user.username = hash1;
  user.password = hash2;

  Request request = new Request();
  request.user = user;

  printNewLine("signup user");
  await signup(request);

  printNewLine("signim user");
  await signin(request);

  printNewLine("All accounts");
  List<Account> accounts = await getAccounts(request);

  printNewLine('#1 - Total sum of all deposits in all agencies');
  int totalSum = 0;
  accounts.forEach((account) => {totalSum += account.balance});
  printNewLine(totalSum);

  printNewLine(
      '#2 - Total sum of all deposits in acounts with more than 100 reais');
  int totalAccountsMoreThan100Reais =
      accounts.where((account) => account.balance > 100).toList().length;
  printNewLine(totalAccountsMoreThan100Reais);

  printNewLine(
      '#3 - Number of accounts with balance more than 100 into agency 33');
  List<Account> accountsAgency33 =
      accounts.where((account) => account.agency == 33).toList();

  int totalAccountWithMoreThan100 = accountsAgency33
      .where((account) => account.balance > 100)
      .toList()
      .length;
  printNewLine(totalAccountWithMoreThan100);

  printNewLine('#4 - Agency with max balance');

  var accountsGroupedByAgency = groupBy(accounts, (account) => account.agency);

  List<int> maxBalanceAccountByAgency = [];
  List<Account> maxBalanceAccount = [];
  List<Account> minBalanceAccount = [];
  List<Account> accountsAgency47 = [];

  accountsGroupedByAgency.forEach((agencyNumber, agencyList) {
    agencyList.sort((acount, nextAccount) {
      return acount.balance.compareTo(nextAccount.balance);
    });

    minBalanceAccount.add(agencyList.first);
    maxBalanceAccount.add(agencyList.last);
    maxBalanceAccountByAgency.add(agencyList.last.balance);

    int totalBalance = 0;
    agencyList.forEach((account) {
      totalBalance += account.balance;
      if (account.agency == 47) {
        accountsAgency47.add(account);
      }
    });
    print("The balance of agency ${agencyNumber} is ${totalBalance}");
  });

  printNewLine('#6 - Sum from max balance account by agency');
  print(maxBalanceAccountByAgency.reduce((a, b) => a + b));

  List<Account> highestAccount = maxBalanceAccount.where((account) {
    return account.agency == 10;
  }).toList();
  printNewLine('#7 - Custom with highet balance from agency 10');
  print(highestAccount.first.name);

  List<Account> lowestAccount =
      minBalanceAccount.where((account) => account.agency == 47).toList();
  printNewLine('#8 - Custom with lowest balance from agency 47');
  print(lowestAccount.first.name);

  printNewLine('#9 - Last three accounts with lowest balance from agency 47');
  accountsAgency47.sort((acount, nextAccount) {
    return acount.balance.compareTo(nextAccount.balance);
  });
  accountsAgency47.take(3).toList().forEach((account) => print(account.name));

  printNewLine('#10 - Amount of accounts from agency 47');
  print(accountsAgency47.length);

  printNewLine('#11 - Amount of clients with "Maria" in name from agency 47');
  List<Account> accountsWithMaria = accountsAgency47.where((account) {
    return account.name.contains('Maria');
  }).toList();

  print(accountsWithMaria.length);

  printNewLine('#12 - Next possible id from account');

  print_r(accounts.last.id + 1);
}
