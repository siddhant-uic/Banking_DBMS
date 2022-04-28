// ignore_for_file: prefer_const_constructors

import 'package:banking_app/services/api.dart';
import 'package:banking_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'AccountDetailsPage.dart';
import 'services/models.dart';

class AccountsPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AccountsPage({Key? key}) : super(key: key);

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    //return scaffold with a list of all user accounts
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: FutureBuilder<List<Account>>(
          future: currentCustomer.currentCustomerValue.custId != 0
              ? getAccounts(currentCustomer.currentCustomerValue.custId)
              : getAccountsByBranchId(
                  currentEmployee.currentEmployeeValue.empId),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListView.builder(
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Text(
                              "All accounts",
                              style: TextStyle(
                                fontSize: 32,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.cyan[300],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return accountWidget(context, snapshot.data![index - 1]);
                    }
                  },
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                  padding: const EdgeInsets.all(20),
                  child: Text("No Accounts"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

Widget accountWidget(BuildContext context, Account account) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Material(
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AccountDetailsPage(account: account);
              },
            ),
          );
        },
        isThreeLine: false,
        tileColor: Colors.blueGrey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          height: 40,
          padding: EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.wallet_travel, color: Colors.cyan[300]),
        ),
        title: Text(
          'Acc No: ${account.account.toString()}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconColor: Colors.cyan[300],
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(FontAwesome.rupee, color: Colors.cyan[300]),
            SizedBox(
              height: 10,
            ),
            Text(account.balance!.toString(),
                style: TextStyle(color: Colors.white))
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right,
            color: Colors.cyan[300], size: 30.0),
      ),
    ),
  );
}
