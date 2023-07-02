# YHDartSDK
这是一个适用于[云湖](https://www.yhchat.com)的**Dart**SDK  
使用此SDK, 您可以轻松的创建云湖机器人  
---
下面是一个简单的示例:

```dart
import 'dart:async';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:dotenv/dotenv.dart';
import '../lib/openapi.dart';
import '../lib/subscription.dart';

var env = DotEnv()..load(["example/.env"]);

Future<Response> _handlePostRequest(Request request) async {
  final requestBody = await request.readAsString();
  final subscription = Subscription();
  final openapi = Openapi(env["TOKEN"].toString());
  // 接收普通消息
  subscription.onMessageNormal((event) {
    print('Received a normal message: $event');
    openapi.sendMessage("3161064", "user", {
      "text": "按钮",
      "buttons": [
        [
          {"text": "按钮文本", "actionType": 3, "value": "这是value"}
        ]
      ]
    });
  });

  // 处理actionType为3时的事件
  subscription.onButtonReportInline((event) {
    print('Received an instruction message: $event');
    openapi.editMessage(event["msgId"], event["recvId"], event["recvType"],
        "text", {"text": "已编辑"});
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
