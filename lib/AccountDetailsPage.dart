// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:banking_app/DebitCardPage.dart';
import 'package:banking_app/ProfilePage.dart';
import 'package:banking_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'services/models.dart';

class AccountDetailsPage extends StatelessWidget {
  const AccountDetailsPage({Key? key, required this.account}) : super(key: key);
  final Account account;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: FutureBuilder<dynamic>(
        future: getAccountDetails(account.account!),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.runtimeType == DepositoryAcc) {
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 16,
              ),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FundsCard(account: account),
                    FieldWidget(
                        field: "Type of account",
                        value: "Depository ${snapshot.data.type} account"),
                    FieldWidget(
                        field: "Minimum Balance",
                        value: "Rs. ${snapshot.data.minBalance}"),
                    FieldWidget(
                        field: "Interest Rate",
                        value: "${snapshot.data.interestRate}%"),
                    FieldWidget(
                        field: "Date of opening",
                        value: DateTime.parse(account.dateOfOpening!)
                            .toString()
                            .split(' ')[0]),
                    FieldWidget(
                        field: "Branch ID", value: account.branchId.toString()),
                    SizedBox(
                      height: 16,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DebitCardPage(
                                balance: account.balance!,
                                cardNo: snapshot.data!.debitCard.toInt(),
                              ),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.blueGrey[700],
                        title: Text(
                          "Debit Card",
                          style: TextStyle(color: Colors.cyan[300]),
                        ),
                        subtitle: Text(
                          snapshot.data.debitCard.toInt().toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        trailing: Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasData && snapshot.data.runtimeType == LoanAcc) {
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 16,
              ),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FundsCard(account: account),
                    FieldWidget(
                        field: "Type of account", value: "Loan account"),
                    FieldWidget(
                        field: "Interest Rate",
                        value: "${snapshot.data.interestRate}%"),
                    FieldWidget(
                        field: "Date of opening",
                        value: DateTime.parse(account.dateOfOpening!)
                            .toString()
                            .split(' ')[0]),
                    FieldWidget(
                        field: "Date of repayment",
                        value: snapshot.data.repaymentDate!
                            .toString()
                            .split(' ')[0]),
                    FieldWidget(
                        field: "Branch ID", value: account.branchId.toString()),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class FundsCard extends StatelessWidget {
  final Account account;
  const FundsCard({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Balance',
              style: TextStyle(
                fontSize: 16,
                // fontFamily: 'Poppins',
                color: Colors.cyan,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '\₹${NumberFormat().format(account.balance)}',
              style: TextStyle(
                  fontSize: 56,
                  // fontFamily: 'Poppins',
                  height: 1.2,
                  // color: CustomColors.black90,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              child: Divider(color: Colors.cyan[300]),
              width: double.infinity,
            ),
            SizedBox(height: 8),
            Text(
              'Acc No: ${account.account}',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey[200]),
            ),
          ],
        ),
      ),
    );
  }
}
