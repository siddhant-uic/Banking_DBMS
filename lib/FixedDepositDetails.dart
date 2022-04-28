// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:banking_app/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'services/models.dart';

class FixedDepositDetailsPage extends StatelessWidget {
  const FixedDepositDetailsPage({Key? key, required this.fixedDeposit})
      : super(key: key);
  final FixedDeposit fixedDeposit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixed Deposit'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FixedDepositCard(fixedDeposit: fixedDeposit),
              FieldWidget(
                  field: "Tenure Months",
                  value: "${fixedDeposit.tenureMonth} month(s)"),
              FieldWidget(field: "ROI", value: "${fixedDeposit.roi}%"),
              FieldWidget(
                field: "Date of opening",
                value: fixedDeposit.dateOfCreation.toString().split(' ')[0],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FixedDepositCard extends StatelessWidget {
  final FixedDeposit fixedDeposit;
  const FixedDepositCard({
    Key? key,
    required this.fixedDeposit,
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
              '\₹${NumberFormat().format(fixedDeposit.amount)}',
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
              'Deposit No: ${fixedDeposit.depositNo}',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey[200]),
            ),
          ],
        ),
      ),
    );
  }
}
