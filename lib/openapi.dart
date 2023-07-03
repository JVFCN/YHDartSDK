import 'dart:convert';
import 'package:http/http.dart' as http;

class Openapi {
  static const String baseUrl = "https://chat-go.jwzhd.com/open-apis/v1";
  final String token;

  Openapi(this.token);

  Future<http.Response> sendTextMessage(
      String recvId, String recvType, Map content) {
    return sendMessage(recvId, recvType, "text", content);
  }

  Future<http.Response> sendMarkdownMessage(
      String recvId, String recvType, Map content) {
    return sendMessage(recvId, recvType, "markdown", content);
  }

  Future<http.Response> batchSendTextMessage(
      List recvId, String recvType, String contentType, Map content) {
    final params = {
      "recvId": recvId,
      "recvType": recvType,
      "contentType": contentType,
      "content": content
    };
    final headers = {'Content-Type': 'application/json'};
    return http.post(Uri.parse('$baseUrl/bot/batch_send?token=$token'),
        headers: headers, body: json.encode(params));
  }

  Future<http.Response> sendMessage(
      recvId, String recvType, String contentType, Map content) {
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

  Future<http.Response> editMessage(String msgId, String recvId,
      String recvType, String contentType, Map content) {
    final params = {
      "msgId": msgId,
      "recvId": recvId,
      "recvType": recvType,
      "contentType": contentType,
      "content": content
    };

    final headers = {'Content-Type': 'application/json'};
    return http.post(Uri.parse('$baseUrl/bot/edit?token=$token'),
        headers: headers, body: json.encode(params));
  }

  Future<http.Response> SetBotBorad(
      String recvId, String recvType, String contentType, String content) {
    final params = {
      "recvId": recvId,
      "recvType": recvType,
      "content": content,
      "contentType": contentType
    };
    final headers = {'Content-Type': 'application/json'};
    return http.post(Uri.parse('$baseUrl/bot/board?token=$token'),
        headers: headers, body: json.encode(params));
  }
}
