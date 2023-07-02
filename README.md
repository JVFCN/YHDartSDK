# YHDartSDK
这是一个适用于[云湖](https://www.yhchat.com)的**Dart**SDK  
使用此SDK, 您可以轻松的创建云湖机器人  
---
下面是一个简单的发送/接收消息的示例:

```dart
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

  // 接收普通消息
  subscription.onMessageNormal((event) {
    print('Received a normal message: $event');
    openapi.sendMessage("3161064", "user", {"text": "Hello"});
  });

  // 接收指令消息
  subscription.onMessageInstruction((event) {
    print('Received an instruction message: $event');
  });
  subscription.listen(requestBody);

  return Response.ok('Event received');
}

void main(List<String> args) async {
  // 启动程序
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_handlePostRequest);
  final server = await io.serve(handler, InternetAddress.anyIPv4, 7888);

  print('Serving at http://${server.address.host}:${server.port}');
}

```