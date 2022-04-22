import 'dart:convert';

import 'package:banking_app/services/models.dart';
import 'package:http/http.dart' as http;

var client = http.Client();
String url = "http://10.0.2.2:3000";
String customersEndpoint = "/customers";

Future<Customer> loginCustomer(String custId, String password) async {
  Uri uri =
      Uri.parse(url + customersEndpoint + "/login/" + custId + "/" + password);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    print(response.body);
    return Customer.fromJson(json.decode(response.body)[0]);
  } else {
    throw Exception('Failed to load album');
  }
}
