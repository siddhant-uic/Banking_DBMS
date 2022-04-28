// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:banking_app/services/api.dart';
import 'package:banking_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'services/models.dart';

class RequestLoanPage extends StatefulWidget {
  RequestLoanPage({Key? key}) : super(key: key);

  @override
  State<RequestLoanPage> createState() => _RequestLoanPageState();
}

class _RequestLoanPageState extends State<RequestLoanPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> textFieldsValue = ["", ""];
  String type = "HOME";
  String branch = "5698";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Loan'),
      ),
      body: FutureBuilder<List<String>>(
          future: getAllBranchIDs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Loan Type"),
                          DropdownButton<String>(
                            value: type,
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.cyan,
                            ),
                            elevation: 16,
                            style: const TextStyle(color: Colors.white),
                            underline: Container(
                              height: 2,
                              color: Colors.cyan,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                // dropdownValue = newValue!;
                                type = newValue!;
                              });
                            },
                            dropdownColor: Colors.blueGrey[700],
                            items: <String>[
                              "HOME",
                              "PERSONAL",
                              "OTHER",
                              "VEHICLE",
                              "EDUCATION"
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Branch Id"),
                          DropdownButton<String>(
                            value: branch,
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.cyan,
                            ),
                            elevation: 16,
                            style: const TextStyle(color: Colors.white),
                            underline: Container(
                              height: 2,
                              color: Colors.cyan,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                // dropdownValue = newValue!;
                                branch = newValue!;
                              });
                            },
                            dropdownColor: Colors.blueGrey[700],
                            items: snapshot.data! .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your amount';
                              }
                              textFieldsValue[0] = (value);
                              return null;
                            },
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Ionicons.cash_outline),
                              hintText: 'Amount',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              label: Text("Amount"),
                              // floatingLabelAlignment: FloatingLabelAlignment.center,

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter duration months';
                              }
                              textFieldsValue[1] = (value);
                              return null;
                            },
                            maxLines: 1,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Ionicons.time_outline),
                              hintText: 'Duration months',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              label: Text("Duration months"),
                              // floatingLabelAlignment: FloatingLabelAlignment.center,

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await requestLoan(int.parse(textFieldsValue[1]),
                              double.parse(textFieldsValue[0]), type, branch);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Request successful"),
                            ),
                          );
                        }
                      },
                      child: Text("Tap to request"),
                      style: ButtonStyle(
                        // backgroundColor: Colors.blueGrey[700],
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        textStyle: MaterialStateProperty.all(
                          TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 40,
                          ),
                        ),
                        side: MaterialStateProperty.all(
                          BorderSide(
                            color: Colors.blueGrey[700]!,
                            width: 2,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
