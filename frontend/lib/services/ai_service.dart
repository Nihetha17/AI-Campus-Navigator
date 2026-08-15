import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  final String baseUrl = 'http://localhost:5000';

  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message}),
    );

    final data = jsonDecode(response.body);

    return data['response'];
  }

  Future<List<dynamic>> getHistory() async {
    final response = await http.get(Uri.parse('$baseUrl/history'));

    final data = jsonDecode(response.body);

    return data['chats'];
  }
}
