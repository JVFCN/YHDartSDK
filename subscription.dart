import 'dart:convert';

class Subscription {
  Function(Map<dynamic, dynamic>)? onMessageNormalSubscriber;
  Function(Map<dynamic, dynamic>)? onMessageInstructionSubscriber;
  Function(Map<dynamic, dynamic>)? onGroupJoinSubscriber;
  Function(Map<dynamic, dynamic>)? onGroupLeaveSubscriber;
  Function(Map<dynamic, dynamic>)? onBotFollowedSubscriber;
  Function(Map<dynamic, dynamic>)? onBotUnfollowedSubscriber;
  Function(Map<dynamic, dynamic>)? onButtonReportInlineSubscriber;

  Subscription();

  void listen(String request) {
    final jsonRequest = json.decode(request);
    final eventType = jsonRequest['header']['eventType'];
    final event = jsonRequest['event'];

    switch (eventType) {
      case 'message.receive.normal':
        onMessageNormalSubscriber?.call(event);
        break;
      case 'message.receive.instruction':
        onMessageInstructionSubscriber?.call(event);
        break;
    }
  }

  void onMessageNormal(Function(Map<dynamic, dynamic> event) func) {
    onMessageNormalSubscriber = func;
  }

  void onMessageInstruction(Function(Map<dynamic, dynamic> event) func) {
    onMessageInstructionSubscriber = func;
  }

}
