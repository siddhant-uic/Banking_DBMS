// ignore_for_file: prefer_const_constructors

import 'package:banking_app/services/models.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required this.customer}) : super(key: key);
  final Customer customer;
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      // Display details of customer in column
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Customer Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Customer Id: ${widget.customer.custId}',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Customer Income: ${widget.customer.income}',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Customer Credit score: ${widget.customer.creditScore}',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Customer Aadhar No: ${widget.customer.aadharNo}',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            // list of buttons
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/transactions');
              },
              child: const Text('Accounts'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/loan');
              },
              child: const Text('Loans'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/loan_status');
              },
              child: const Text('Fixed Deposits'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/transactions');
              },
              child: const Text('Credit Cards'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/loan');
              },
              child: const Text('Profile settings'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/loan_status');
              },
              child: const Text('Logout'),
            ),
          ]
        ),
      ),
      
    );
  }
}
