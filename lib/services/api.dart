import 'dart:convert';

import 'package:banking_app/services/auth.dart';
import 'package:banking_app/services/models.dart';
import 'package:http/http.dart' as http;

var client = http.Client();
String url = "http://10.0.2.2:3000";
String customersEndpoint = "/customers";
String accountsEndpoint = "/accounts";
String personEndpoint = "/person";
String fixedDepositsEndpoint = "/FD";
String transactionEndpoint = "/transactions";
String employeeEndpoint = "/employee";
String branchEndpoint = "/branch";

Future<void> loginCustomer(String custId, String password) async {
  Uri uri =
      Uri.parse(url + customersEndpoint + "/login/" + custId + "/" + password);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    print(response.body);
    Customer cust = Customer.fromJson(json.decode(response.body)[0]);
    currentCustomer.login(cust);
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<Account>> getAccounts(int custId) async {
  Uri uri = Uri.parse(url + accountsEndpoint + "/" + custId.toString());
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    print(response.body);
    List<Account> accounts = [];
    List<dynamic> jsonAccounts = json.decode(response.body);
    for (var jsonAccount in jsonAccounts) {
      accounts.add(Account.fromJson(jsonAccount));
    }
    return accounts;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<Person> getPersonByAadhar(int aadharNo) async {
  Uri uri = Uri.parse(url + personEndpoint + "/" + aadharNo.toString());
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    // print(response.body);
    return Person.fromJson(json.decode(response.body)[0]);
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<FixedDeposit>> getFixedDeposits(int custId) async {
  Uri uri = Uri.parse(
      url + fixedDepositsEndpoint + "/" + "customerId=" + custId.toString());
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    print(response.body);
    List<FixedDeposit> fixedDeposits = [];
    List<dynamic> jsonFixedDeposits = json.decode(response.body);
    for (var jsonFixedDeposit in jsonFixedDeposits) {
      fixedDeposits.add(FixedDeposit.fromJson(jsonFixedDeposit));
    }
    return fixedDeposits;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<dynamic> getAccountDetails(int account) async {
  Uri uri =
      Uri.parse(url + accountsEndpoint + "/details/" + account.toString());
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    if (json.decode(response.body)[0]["Type"] == null) {
      return LoanAcc.fromJson(json.decode(response.body)[0]);
    } else {
      return DepositoryAcc.fromJson(json.decode(response.body)[0]);
    }
  } else {
    throw Exception('Failed to load album');
  }
}

Future<BankCard> getBankCard(int cardNo, String cardType) async {
  Uri uri = Uri.parse(
      url + accountsEndpoint + "/" + cardType + "/" + cardNo.toString());
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return BankCard.fromJson(json.decode(response.body)[0]);
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<Transaction>> getTransactionsByCustId(int custId) async {
  Uri uri = Uri.parse(url + transactionEndpoint + "/" + custId.toString());
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<Transaction> transactions = [];
    List<dynamic> jsonTransactions = json.decode(response.body);
    for (var jsonTransaction in jsonTransactions) {
      transactions.add(Transaction.fromJson(jsonTransaction));
    }
    transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return transactions;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<AssetsLiabilities> getAssetsLiabilities(int custId) async {
  Uri uri = Uri.parse(url + customersEndpoint + "/totals/" + custId.toString());
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return AssetsLiabilities.fromJson(json.decode(response.body)[0]);
  } else {
    throw Exception('Failed to load album');
  }
}

Future loginEmployee(String empId, String password) async {
  Uri uri =
      Uri.parse(url + employeeEndpoint + "/login/" + empId + "/" + password);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    print(response.body);
    Employee emp = Employee.fromJson(json.decode(response.body)[0]);
    currentEmployee.login(emp);
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<Loan>> getPendingLoanRequests(int branchId) async {
  Uri uri = Uri.parse(url + branchEndpoint + "/loans/" + branchId.toString());
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<Loan> loans = [];
    List<dynamic> jsonLoans = json.decode(response.body);
    for (var jsonLoan in jsonLoans) {
      loans.add(Loan.fromJson(jsonLoan));
    }
    loans.sort((a, b) => b.dateOfOpening.compareTo(a.dateOfOpening));
    return loans;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<Account>> getAccountsByBranchId(int branchId) async {
  Uri uri =
      Uri.parse(url + accountsEndpoint + "/branch/" + branchId.toString());
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<Account> accounts = [];
    List<dynamic> jsonAccounts = json.decode(response.body);
    for (var jsonAccount in jsonAccounts) {
      accounts.add(Account.fromJson(jsonAccount));
    }
    return accounts;
  } else {
    throw Exception('Failed to load album');
  }
}

Future approveLoan(int requestId) async {
  Uri uri = Uri.parse(url + branchEndpoint + "/approve");
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'requestId': requestId,
    }),
  );

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}
Future rejectLoan(int requestId) async {
  Uri uri = Uri.parse(url + branchEndpoint + "/reject");
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'requestId': requestId,
    }),
  );

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<FixedDeposit>> getFixedDepositsByBranchId(int branchId) async {
  Uri uri =
      Uri.parse(url + branchEndpoint + "/fixedDeposit/" + branchId.toString());
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<FixedDeposit> fixedDeposits = [];
    List<dynamic> jsonFixedDeposits = json.decode(response.body);
    for (var jsonFixedDeposit in jsonFixedDeposits) {
      fixedDeposits.add(FixedDeposit.fromJson(jsonFixedDeposit));
    }
    return fixedDeposits;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<http.Response> createTransaction(double amount, int accountNo) async {
  Uri uri = Uri.parse(url + transactionEndpoint + '/create');
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'amount': amount,
      'accountNumber': accountNo,
      'customerId': currentCustomer.currentCustomerValue.custId,
      'transactionType': 'DEBIT',
    }),
  );

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Failed to load album');
  }
  return response;
}

Future<List<String>> getAllBranchIDs() async {
  Uri uri = Uri.parse(url + branchEndpoint + "/all");
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<String> branchIds = [];
    List<dynamic> jsonBranchIds = json.decode(response.body);
    for (var jsonBranchId in jsonBranchIds) {
      branchIds.add(jsonBranchId['branchId'].toString());
    }
    return branchIds;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<http.Response> requestLoan(int durationMonths, double amount, String loanType, String branchId) async {
  Uri uri = Uri.parse(url + customersEndpoint + '/requestLoan');
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'durationMonths': durationMonths,
      'amount': amount,
      'loanType': loanType,
      'customerId': currentCustomer.currentCustomerValue.custId,
      'branchId': branchId,
    }),
  );

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Failed to load album');
  }
  return response;
}