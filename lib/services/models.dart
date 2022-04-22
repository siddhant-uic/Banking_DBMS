// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
    Customer({
        required this.custId,
        required this.password,
        required this.income,
        required this.creditScore,
        required this.aadharNo,
    });

    int custId;
    String password;
    int income;
    int creditScore;
    int aadharNo;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        custId: json["CustID"],
        password: json["Password"],
        income: json["Income"],
        creditScore: json["Credit Score"],
        aadharNo: json["AadharNo"],
    );

    Map<String, dynamic> toJson() => {
        "CustID": custId,
        "Password": password,
        "Income": income,
        "Credit Score": creditScore,
        "AadharNo": aadharNo,
    };
}
