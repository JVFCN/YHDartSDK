// import 'package:http/http.dart';
// import 'openapi.dart';
// import 'subscription.dart';
//
// void main() async {
//   // Replace 'your_token' with your actual token.
//   final openapi = Openapi('71fd5414100748eda678e09763122e53');
//
//   // Send a text message.
//   Response response = await openapi.sendTextMessage('3161064', 'user', {'text': 'Hello, World!'});
//   print('Text message response: ${response.body}');
//
//   // Send a markdown message.
//   response = await openapi.sendMarkdownMessage('3161064', 'user', {'text': '**Bold** text'});
//   print('Markdown message response: ${response.body}');
//
//   // Example JSON request for a normal message event.
//   final jsonString = '''
//   {
//     "header": {
//       "eventType": "message.receive.normal"
//     },
//     "event": {
//       "msgId": "message_id",
//       "content": "Hello"
//     }
//   }
//   ''';
//
//   // Create a Subscription instance and set the event handlers.
//   final subscription = Subscription()
//     ..onMessageNormal((event) {
//       print('Normal message received: ${event['content']}');
//     });
//
//   // Listen for events.
//   subscription.listen(jsonString);
// }
import 'dart:async';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'openapi.dart';
import 'subscription.dart';

Future<Response> _handlePostRequest(Request request) async {
  final requestBody = await request.readAsString();

  final subscription = Subscription();

  subscription.onMessageNormal((event) {
    print('Received a normal message: $event');
    final openapi = Openapi("71fd5414100748eda678e09763122e53");
    openapi.sendMessage("3161064", "user", {"text": "Hello"});
  });

  subscription.onMessageInstruction((event) {
    print('Received an instruction message: $event');
  });
  subscription.listen(requestBody);

  return Response.ok('Event received');
}

void main(List<String> args) async {
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_handlePostRequest);
  final server = await io.serve(handler, InternetAddress.anyIPv4, 7888);

  print('Serving at http://${server.address.host}:${server.port}');
}
