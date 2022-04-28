// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:banking_app/services/api.dart';
import 'package:banking_app/services/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class DebitCardPage extends StatelessWidget {
  const DebitCardPage({Key? key, required this.balance, required this.cardNo})
      : super(key: key);
  final double balance;
  final int cardNo;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Debit Card'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<BankCard>(
          future: getBankCard(cardNo.toInt(), "debitcard"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: const EdgeInsets.all(15),
                child: snapshot.data?.cSubType == "VISA"
                    ? VisaCard(
                        size: size,
                        card: snapshot.data!,
                        balance: balance,
                      )
                    : snapshot.data?.cSubType == "Mastercard"
                        ? MasterCard(
                            size: size,
                            card: snapshot.data!,
                            balance: balance,
                          )
                        : OtherTypeCard(
                            size: size,
                            card: snapshot.data!,
                            balance: balance,
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

class VisaCard extends StatelessWidget {
  const VisaCard({
    Key? key,
    required this.size,
    required this.card,
    required this.balance,
  }) : super(key: key);
  final BankCard card;
  final Size size;
  final double balance;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        height: size.height * 0.23,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.67,
              padding: const EdgeInsets.fromLTRB(16, 10, 0, 20),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(15)),
                color: Colors.deepOrange[700],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/visa_white.png',
                      width: 80, height: 50, fit: BoxFit.cover),
                  Text('₹ ${balance}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white)),
                  const SizedBox(height: 20),
                  Text('CARD NUMBER',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 12)),
                  const SizedBox(height: 5),
                  Text(card.cardNo.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),
            Container(
              width: size.width * 0.27,
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(15)),
                color: Colors.purple[700],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.cyan,
                    ),
                    child: const Icon(Icons.swipe_rounded,
                        color: Colors.white, size: 20),
                  ),
                  const Spacer(),
                  const Text('VALID', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 5),
                  Text(processDate(card.issueDate, card.termYrs),
                      style: TextStyle(fontSize: 15)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MasterCard extends StatelessWidget {
  const MasterCard({
    Key? key,
    required this.size,
    required this.card,
    required this.balance,
  }) : super(key: key);

  final Size size;
  final BankCard card;
  final double balance;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        height: size.height * 0.23,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.67,
              padding: const EdgeInsets.fromLTRB(16, 10, 0, 20),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(15)),
                color: Colors.greenAccent[400],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/mastercard.png',
                      width: 60, height: 50, fit: BoxFit.cover),
                  Text('₹ $balance',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.black)),
                  const SizedBox(height: 20),
                  Text('CARD NUMBER',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7), fontSize: 12)),
                  const SizedBox(height: 5),
                  Text(processCardNo(card.cardNo),
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ],
              ),
            ),
            Container(
              width: size.width * 0.27,
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(15)),
                color: Colors.brown[700],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(Icons.swipe_rounded,
                        color: Colors.greenAccent[400], size: 20),
                  ),
                  const Spacer(),
                  Text('VALID',
                      style: TextStyle(
                          fontSize: 12, color: Colors.white.withOpacity(0.5))),
                  const SizedBox(height: 5),
                  Text(processDate(card.issueDate, card.termYrs),
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OtherTypeCard extends StatelessWidget {
  const OtherTypeCard({
    Key? key,
    required this.size,
    required this.card,
    required this.balance,
  }) : super(key: key);

  final Size size;
  final BankCard card;
  final double balance;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        height: size.height * 0.23,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.67,
              padding: const EdgeInsets.fromLTRB(16, 10, 0, 20),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(15)),
                color: Colors.teal[400],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/paypal.png',
                      width: 60, height: 50, fit: BoxFit.cover),
                  Text('₹ $balance',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white)),
                  const SizedBox(height: 20),
                  Text('CARD NUMBER',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 12)),
                  const SizedBox(height: 5),
                  Text(processCardNo(card.cardNo),
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),
            Container(
              width: size.width * 0.27,
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(15)),
                color: Colors.blueGrey[700],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal[400],
                    ),
                    child: const Icon(Icons.swipe_rounded,
                        color: Colors.white, size: 20),
                  ),
                  const Spacer(),
                  const Text('VALID', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 5),
                  Text(processDate(card.issueDate, card.termYrs),
                      style: TextStyle(fontSize: 15)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String processCardNo(int cardNo) {
  String cardNoStr = cardNo.toString();
  String cardNoStr2 = cardNoStr.substring(0, 4) +
      ' ' +
      cardNoStr.substring(4, 8) +
      ' ' +
      cardNoStr.substring(8, 12) +
      ' ' +
      cardNoStr.substring(12, 16);
  return cardNoStr2;
}

String processDate(DateTime issueDate, int months) {
  return issueDate.add(Duration(days: months * 30)).month.toString() +
      '/' +
      issueDate.add(Duration(days: months * 30)).year.toString();
}
