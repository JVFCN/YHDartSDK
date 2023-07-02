import 'dart:async';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import '../openapi.dart';
import '../subscription.dart';

Future<Response> _handlePostRequest(Request request) async {
  final requestBody = await request.readAsString();
  final subscription = Subscription();
  final openapi = Openapi("TOKEN");

  // ������ͨ��Ϣ��ʹ�÷�����ϢApi
  subscription.onMessageNormal((event) {
    print('Received a normal message: $event');
    openapi.sendMessage("3161064", "user", {"text": "Hello"});
  });

  // ����ָ����Ϣ
  subscription.onMessageInstruction((event) {
    print('Received an instruction message: $event');
  });
  subscription.listen(requestBody);

  return Response.ok('Event received');
}

void main(List<String> args) async {
  // ��������
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_handlePostRequest);
  final server = await io.serve(handler, InternetAddress.anyIPv4, 7888);

  print('Serving at http://${server.address.host}:${server.port}');
}
