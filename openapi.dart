import 'dart:convert';
import 'package:http/http.dart' as http;

class Openapi {
  static const String baseUrl = "https://chat-go.jwzhd.com/open-apis/v1";
  final String token;

  Openapi(this.token);

  Future<http.Response> sendMessage(
      String recvId, String recvType, Map content) {
    return _sendMessage(recvId, recvType, "text", content);
  }

  Future<http.Response> sendMarkdownMessage(
      String recvId, String recvType, Map content) {
    return _sendMessage(recvId, recvType, "markdown", content);
  }

  Future<http.Response> _sendMessage(
      String recvId, String recvType, String contentType, Map content) {
    final params = {
      "recvId": recvId,
      "recvType": recvType,
      "contentType": contentType,
      "content": content
    };
    final headers = {'Content-Type': 'application/json'};
    return http.post(Uri.parse('$baseUrl/bot/send?token=$token'),
        headers: headers, body: json.encode(params));
  }
}
