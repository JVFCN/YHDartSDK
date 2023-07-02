import 'dart:convert';
import 'dart:isolate';

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
      case 'group.join':
        onGroupJoinSubscriber?.call(event);
        break;
      case 'group.leave':
        onGroupLeaveSubscriber?.call(event);
        break;
      case 'bot.followed':
        onBotFollowedSubscriber?.call(event);
        break;
      case 'bot.unfollowed':
        onBotUnfollowedSubscriber?.call(event);
        break;
      case 'button.report.inline':
        onButtonReportInlineSubscriber?.call(event);
    }
  }

  void onMessageNormal(Function(Map<dynamic, dynamic> event) func) {
    onMessageNormalSubscriber = func;
  }

  void onMessageInstruction(Function(Map<dynamic, dynamic> event) func) {
    onMessageInstructionSubscriber = func;
  }

  void onGroupJoin(Function(Map<dynamic, dynamic> event) func) {
    onGroupJoinSubscriber = func;
  }

  void onGroupLeave(Function(Map<dynamic, dynamic> event) func) {
    onGroupLeaveSubscriber = func;
  }

  void onBotFollowed(Function(Map<dynamic, dynamic> event) func) {
    onBotFollowedSubscriber = func;
  }

  void onBotUnfollowed(Function(Map<dynamic, dynamic> event) func) {
    onBotUnfollowedSubscriber = func;
  }

  void onButtonReportInline(Function(Map<dynamic, dynamic> event) func) {
    onButtonReportInlineSubscriber = func;
  }
}
