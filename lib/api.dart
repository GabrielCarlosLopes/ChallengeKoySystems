import 'dart:convert';

import 'package:challenge_koisystems/model/hotels.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Api {
  final url =
      Uri.parse('https://s3.amazonaws.com/koisys-interviews/hotels.json');

  Future<Hotels> getAll() async {
    final response = 
    await http.get(url);

    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

    return Hotels.fromJson(responseJson);
  }
}
