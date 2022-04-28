// ignore_for_file: prefer_const_constructors

import 'package:banking_app/LoginPage.dart';
import 'package:banking_app/services/api.dart';
import 'package:banking_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'services/models.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // return scaffol witth user details
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<Person>(
          future: currentCustomer.currentCustomerValue.custId != 0
              ? getPersonByAadhar(currentCustomer.currentCustomerValue.aadharNo)
              : getPersonByAadhar(
                  currentEmployee.currentEmployeeValue.aadharNo),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.aadharNo != 0) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        SvgPicture.asset(
                          'assets/avatar.svg',
                          height: 120,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        FieldWidget(
                          field: 'Name',
                          value: (snapshot.data!.firstName +
                              " " +
                              snapshot.data!.lastName),
                        ),
                        FieldWidget(
                          field: 'Aadhar',
                          value: snapshot.data!.aadharNo.toString(),
                        ),
                        FieldWidget(
                          field: 'Gender',
                          value: snapshot.data!.gender == "M"
                              ? 'Male'
                              : snapshot.data!.gender == "F"
                                  ? 'Female'
                                  : 'Other',
                        ),
                        FieldWidget(
                          field: "Date of Birth",
                          value: snapshot.data!.dob.toString().split(" ")[0],
                        ),
                        FieldWidget(
                          field: "House No",
                          value: snapshot.data!.houseNo,
                        ),
                        FieldWidget(
                          field: "Locality",
                          value: snapshot.data!.locality,
                        ),
                        FieldWidget(
                          field: "City",
                          value: snapshot.data!.city,
                        ),
                        FieldWidget(
                          field: "State",
                          value: snapshot.data!.state,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/loan_status');
                            currentCustomer.logout();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (route) => false);
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No data found'),
              );
            }
          }),
    );
  }
}

class FieldWidget extends StatelessWidget {
  final String field, value;
  const FieldWidget({
    Key? key,
    required this.field,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Text(
              field,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.cyan[200],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(color: Colors.cyan[200]!),
            )),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
