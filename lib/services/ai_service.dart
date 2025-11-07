import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class AIService {
  final http.Client client;
  AIService({http.Client? client}) : client = client ?? http.Client();

  /// Fetch a "caption" from a public mock endpoint. Simulates AI.
  Future<String> generateCaption() async {
    try {
      // Simulate delay
      await Future.delayed(Duration(seconds: 2));

      // Example mock endpoint: we will fetch a quote and tweak it
      final uri = Uri.parse('https://dummyjson.com/quotes/random');
      final resp = await client.get(uri).timeout(Duration(seconds: 8));
      if (resp.statusCode == 200) {
        final j = jsonDecode(resp.body);
        final quote = j['quote'] as String? ?? 'Lovely day!';
        // Post-process to look like a caption
        return '"$quote" — #awesome';
      } else {
        throw Exception('AI endpoint returned ${resp.statusCode}');
      }
    } catch (e) {
      // fallback captions
      final fallback = [
        "Good vibes only.",
        "Living my best life.",
        "Tiny moments, big memories."
      ];
      return fallback[Random().nextInt(fallback.length)];
    }
  }
}
