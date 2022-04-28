// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators, prefer_if_null_operators

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


class Account {
	int? account;
	double? balance;
	int? custId;
	int? branchId;
	String? dateOfOpening;

	Account({
		this.account, 
		this.balance, 
		this.custId, 
		this.branchId, 
		this.dateOfOpening, 
	});

	factory Account.fromJson(Map<String, dynamic> data) {
		return Account(
			account: data['Account#'] as int?,
			balance: (data['Balance'] as num?)?.toDouble(),
			custId: data['CustID'] as int?,
			branchId: data['BranchID'] as int?,
			dateOfOpening: data['DateOfOpening'] as String?,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'Account#': account,
			'Balance': balance,
			'CustID': custId,
			'BranchID': branchId,
			'DateOfOpening': dateOfOpening,		};
	}
}

class Person {
    Person({
        required this.aadharNo,
        required this.firstName,
        required this.lastName,
        required this.dob,
        required this.gender,
        required this.houseNo,
        required this.locality,
        required this.city,
        required this.state,
    });

    int aadharNo;
    String firstName;
    String lastName;
    DateTime dob;
    String gender;
    String houseNo;
    String locality;
    String city;
    String state;

    factory Person.fromJson(Map<String, dynamic> json) => Person(
        aadharNo: json["AadharNo"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        dob: DateTime.parse(json["DOB"]),
        gender: json["Gender"],
        houseNo: json["HouseNo"],
        locality: json["Locality"] == null ? "" : json["Locality"],
        city: json["City"],
        state: json["State"],
    );

    Map<String, dynamic> toJson() => {
        "AadharNo": aadharNo,
        "FirstName": firstName,
        "LastName": lastName,
        "DOB": dob.toIso8601String(),
        "Gender": gender,
        "HouseNo": houseNo,
        "Locality": locality,
        "City": city,
        "State": state,
    };
}

class FixedDeposit {
    FixedDeposit({
        required this.depositNo,
        required this.tenureMonth,
        required this.dateOfCreation,
        required this.amount,
        required this.roi,
        required this.custId,
    });

    int depositNo;
    int tenureMonth;
    DateTime dateOfCreation;
    int amount;
    int roi;
    int custId;

    factory FixedDeposit.fromJson(Map<String, dynamic> json) => FixedDeposit(
        depositNo: json["DepositNo"],
        tenureMonth: json["TenureMonth"],
        dateOfCreation: DateTime.parse(json["DateOfCreation"]),
        amount: json["Amount"],
        roi: json["ROI"],
        custId: json["CustId"],
    );

    Map<String, dynamic> toJson() => {
        "DepositNo": depositNo,
        "TenureMonth": tenureMonth,
        "DateOfCreation": dateOfCreation.toIso8601String(),
        "Amount": amount,
        "ROI": roi,
        "CustId": custId,
    };
}

class DepositoryAcc {
    DepositoryAcc({
        required this.account,
        required this.interestRate,
        required this.minBalance,
        required this.type,
        required this.debitCard,
    });

    int account;
    int interestRate;
    double minBalance;
    String type;
    double debitCard;

    factory DepositoryAcc.fromJson(Map<String, dynamic> json) => DepositoryAcc(
        account: json["Account#"],
        interestRate: json["InterestRate"],
        minBalance: json["minBalance"] == null ? 0 : json["minBalance"].toDouble(),
        type: json["Type"],
        debitCard: json["DebitCard#"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "Account#": account,
        "InterestRate": interestRate,
        "minBalance": minBalance,
        "Type": type,
        "DebitCard#": debitCard,
    };
}

class LoanAcc {
    LoanAcc({
        required this.interestRate,
        required this.repaymentDate,
        required this.account,
    });

    int interestRate;
    DateTime repaymentDate;
    int account;

    factory LoanAcc.fromJson(Map<String, dynamic> json) => LoanAcc(
        interestRate: json["InterestRate"],
        repaymentDate: DateTime.parse(json["RepaymentDate"]),
        account: json["Account#"],
    );

    Map<String, dynamic> toJson() => {
        "InterestRate": interestRate,
        "RepaymentDate": repaymentDate.toIso8601String(),
        "Account#": account,
    };
}

class BankCard {
    BankCard({
        required this.cardNo,
        required this.termYrs,
        required this.issueDate,
        required this.cType,
        required this.cSubType,
    });

    int cardNo;
    int termYrs;
    DateTime issueDate;
    String cType;
    String cSubType;

    factory BankCard.fromJson(Map<String, dynamic> json) => BankCard(
        cardNo: json["CardNo"],
        termYrs: json["Term_Yrs"],
        issueDate: DateTime.parse(json["IssueDate"]),
        cType: json["CType"],
        cSubType: json["CSubType"],
    );

    Map<String, dynamic> toJson() => {
        "CardNo": cardNo,
        "Term_Yrs": termYrs,
        "IssueDate": issueDate.toIso8601String(),
        "CType": cType,
        "CSubType": cSubType,
    };
}

// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);


class Transaction {
    Transaction({
        required this.transactionId,
        required this.amount,
        required this.status,
        required this.type,
        required this.dateTime,
        required this.custId,
        required this.account,
    });

    int transactionId;
    double amount;
    String status;
    String type;
    DateTime dateTime;
    int custId;
    int account;

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        transactionId: json["TransactionID"],
        amount: json["Amount"].toDouble(),
        status: json["Status"],
        type: json["Type"],
        dateTime: DateTime.parse(json["DateTime"]),
        custId: json["CustID"],
        account: json["Account#"],
    );

    Map<String, dynamic> toJson() => {
        "TransactionID": transactionId,
        "Amount": amount,
        "Status": status,
        "Type": type,
        "DateTime": dateTime.toIso8601String(),
        "CustID": custId,
        "Account#": account,
    };
}
class AssetsLiabilities {
    AssetsLiabilities({
        required this.assets,
        required this.liabilities,
    });

    double assets;
    double liabilities;

    factory AssetsLiabilities.fromJson(Map<String, dynamic> json) => AssetsLiabilities(
        assets: json["assets"] == null ? 0 : json["assets"].toDouble(),
        liabilities: json["liabilities"] == null ? 0 : json["liabilities"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "assets": assets == null ? null : assets,
        "liabilities": liabilities == null ? null : liabilities,
    };
}

class Employee {
    Employee({
        required this.empId,
        required this.salary,
        required this.aadharNo,
        required this.password,
        required this.branchId,
        required this.doj,
    });

    int empId;
    int salary;
    int aadharNo;
    String password;
    int branchId;
    DateTime doj;

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        empId: json["empID"] == null ? null : json["empID"],
        salary: json["Salary"] == null ? null : json["Salary"],
        aadharNo: json["AadharNo"] == null ? null : json["AadharNo"],
        password: json["password"] == null ? null : json["password"],
        branchId: json["branchID"] == null ? null : json["branchID"],
        doj: json["DOJ"] == null ? DateTime.now() : DateTime.parse(json["DOJ"]),
    );

    Map<String, dynamic> toJson() => {
        "empID": empId == null ? null : empId,
        "Salary": salary == null ? null : salary,
        "AadharNo": aadharNo == null ? null : aadharNo,
        "password": password == null ? null : password,
        "branchID": branchId == null ? null : branchId,
        "DOJ": doj == null ? null : doj.toIso8601String(),
    };
}

class Loan {
    Loan({
        required this.requestId,
        required this.dateOfOpening,
        required this.amount,
        required this.durationMonths,
        required this.type,
        required this.custId,
        required this.branchId,
        required this.acc,
        required this.status,
    });

    int requestId;
    DateTime dateOfOpening;
    int amount;
    int durationMonths;
    String type;
    int custId;
    int branchId;
    int acc;
    String status;

    factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        requestId: json["requestID"] == null ? null : json["requestID"],
        dateOfOpening: json["DateOfOpening"] == null ? DateTime.now() : DateTime.parse(json["DateOfOpening"]),
        amount: json["Amount"] == null ? null : json["Amount"],
        durationMonths: json["DurationMonths"] == null ? null : json["DurationMonths"],
        type: json["Type"] == null ? null : json["Type"],
        custId: json["CustId"] == null ? null : json["CustId"],
        branchId: json["BranchId"] == null ? null : json["BranchId"],
        acc: json["Acc#"] == null ? null : json["Acc#"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "requestID": requestId == null ? null : requestId,
        "DateOfOpening": dateOfOpening == null ? null : dateOfOpening.toIso8601String(),
        "Amount": amount == null ? null : amount,
        "DurationMonths": durationMonths == null ? null : durationMonths,
        "Type": type == null ? null : type,
        "CustId": custId == null ? null : custId,
        "BranchId": branchId == null ? null : branchId,
        "Acc#": acc == null ? null : acc,
        "status": status == null ? null : status,
    };
}
