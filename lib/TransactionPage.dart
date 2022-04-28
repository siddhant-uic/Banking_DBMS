// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:banking_app/services/api.dart';
import 'package:banking_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'services/models.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> textFieldsValue = ["", ""];
  late final Account account;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Transaction'),
      ),
      body: FutureBuilder<List<Account>>(
          future: getAccounts(currentCustomer.currentCustomerValue.custId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              account = snapshot.data!.first;
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
                          Text("Account Number"),
                          DropdownButton<Account>(
                            value: account,
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
                            onChanged: (Account? newValue) {
                              setState(() {
                                // dropdownValue = newValue!;
                                account = newValue!;
                              });
                            },
                            dropdownColor: Colors.blueGrey[700],
                            items: snapshot.data!
                                .map<DropdownMenuItem<Account>>(
                                    (Account value) {
                              return DropdownMenuItem<Account>(
                                value: value,
                                child: Text(value.account.toString()),
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
                                return 'Please enter your password';
                              }
                              textFieldsValue[1] = (value);
                              return null;
                            },
                            maxLines: 1,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Ionicons.lock_closed_outline),
                              hintText: 'Password',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              label: Text("Password"),
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
                          double amount = double.parse(textFieldsValue[0]);
                          int accountNo = account.account!;
                          String password = textFieldsValue[1];
                          if (password ==
                              currentCustomer.currentCustomerValue.password) {
                            await createTransaction(
                              amount,
                              accountNo,
                            );
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Transaction successful"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Wrong Password"),
                              ),
                            );
                          }
                          
                        }
                      },
                      child: Text("Tap to pay"),
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
