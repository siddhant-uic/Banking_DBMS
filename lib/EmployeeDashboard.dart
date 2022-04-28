// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_string_interpolations

import 'package:banking_app/AccountDetailsPage.dart';
import 'package:banking_app/Accounts.dart';
import 'package:banking_app/FixedDeposits.dart';
import 'package:banking_app/LoginPage.dart';
import 'package:banking_app/ProfilePage.dart';
import 'package:banking_app/services/api.dart';
import 'package:banking_app/services/auth.dart';
import 'package:banking_app/services/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  const EmployeeDashboardScreen({Key? key}) : super(key: key);
  @override
  State<EmployeeDashboardScreen> createState() =>
      _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  List<Widget> pages = [
    HomeScreen(employee: CurrentEmployee().currentEmployeeValue),
    AccountsPage(),
    ProfilePage(),
  ];
  int _widgetIndex = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Employee>(
      stream: currentEmployee.currentEmployee,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.empId != 0) {
          pages = [
            HomeScreen(employee: snapshot.data!),
            AccountsPage(),
            ProfilePage(),
          ];
          return Scaffold(
            // Display details of customer in column
            body: pages.elementAt(_widgetIndex),

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _widgetIndex,
              onTap: (value) {
                setState(() {
                  _widgetIndex = value;
                });
              },
              backgroundColor: Colors.blueGrey[900],
              // fixedColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              selectedIconTheme: IconThemeData(color: Colors.cyan),
              selectedLabelStyle: TextStyle(color: Colors.cyan),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Ionicons.wallet_outline),
                    label: 'Wallet',
                    activeIcon: Icon(Ionicons.wallet)),
                BottomNavigationBarItem(
                  activeIcon: Icon(MaterialCommunityIcons.account_cash),
                  icon: Icon(MaterialCommunityIcons.account_cash_outline),
                  label: 'Accounts',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Ionicons.person),
                  icon: Icon(Ionicons.person_outline),
                  label: 'Profile',
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData &&
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginPage();
          }));
          return Center(
            child: Text('No customer logged in'),
          );
        }
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.employee,
  }) : super(key: key);
  final Employee employee;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Loan> loans = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Person>(
        future: getPersonByAadhar(widget.employee.aadharNo),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 64.0, 20, 0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, ${snapshot.data!.firstName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SalaryCard(employee: widget.employee),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Approve Loans',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<List<Loan>>(
                      future: getPendingLoanRequests(widget.employee.branchId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          loans = snapshot.data!;
                          return Container(
                            height: 258,
                            child: AnimatedList(
                              key: _listKey,
                              shrinkWrap: true,
                              initialItemCount: loans.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index, animation) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: LoanCard(
                                    loan: loans[index],
                                    animationKey: _listKey,
                                    index: index,
                                    list: loans,
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Container(
                            height: 150,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class SalaryCard extends StatelessWidget {
  final Employee employee;
  const SalaryCard({
    Key? key,
    required this.employee,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Salary',
              style: TextStyle(
                fontSize: 16,
                // fontFamily: 'Poppins',
                color: Colors.cyan,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '₹${NumberFormat().format(employee.salary)}',
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
              'Branch ID: ${employee.branchId}',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey[200]),
            ),
          ],
        ),
      ),
    );
  }
}

// TransactionCard
class LoanCard extends StatelessWidget {
  const LoanCard({
    Key? key,
    required this.animationKey,
    required this.loan,
    required this.index,
    required this.list,
  }) : super(key: key);
  final Loan loan;
  final GlobalKey<AnimatedListState> animationKey;
  final int index;
  final List<Loan> list;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 2 / 3,
        height: 200,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${loan.type}',
                  style: TextStyle(
                    fontSize: 16,
                    // fontFamily: 'Poppins',
                    color: Colors.cyan,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              '₹${NumberFormat().format(loan.amount)}',
              style: TextStyle(
                fontSize: 28,
                // fontFamily: 'Poppins',
                height: 1.2,
                // color: CustomColors.black90,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Container(
              child: Divider(color: Colors.cyan[300]),
              width: double.infinity,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From:',
                      style:
                          TextStyle(fontSize: 16, color: Colors.blueGrey[200]),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${loan.dateOfOpening.toString().split(" ")[0]}',
                      style:
                          TextStyle(fontSize: 16, color: Colors.blueGrey[200]),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Duration:',
                      style:
                          TextStyle(fontSize: 16, color: Colors.blueGrey[200]),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${loan.durationMonths} Months',
                      style:
                          TextStyle(fontSize: 16, color: Colors.blueGrey[200]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    await rejectLoan(loan.requestId);
                    list.removeAt(index);
                    animationKey.currentState!.removeItem(
                      index,
                      (context, animation) => Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width * 2 / 3,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  },
                  child: Text("Reject"),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await approveLoan(loan.requestId);
                    list.removeAt(index);
                    animationKey.currentState!.removeItem(
                      index,
                      (context, animation) => Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width * 2 / 3,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.blueGrey[700])),
                  child: Text("Accept"),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Spacer(),
                Text(
                  "Request Id: ${loan.requestId}",
                  style: TextStyle(fontSize: 12, color: Colors.blueGrey[200]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
