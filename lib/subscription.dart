import 'dart:convert';

class Subscription {
  Function(Map<dynamic, dynamic>)? _onMessageNormalSubscriber;
  Function(Map<dynamic, dynamic>)? _onMessageInstructionSubscriber;
  Function(Map<dynamic, dynamic>)? _onGroupJoinSubscriber;
  Function(Map<dynamic, dynamic>)? _onGroupLeaveSubscriber;
  Function(Map<dynamic, dynamic>)? _onBotFollowedSubscriber;
  Function(Map<dynamic, dynamic>)? _onBotUnfollowedSubscriber;
  Function(Map<dynamic, dynamic>)? _onButtonReportInlineSubscriber;

  Subscription();

  void listen(String request) {
    final jsonRequest = json.decode(request);
    final eventType = jsonRequest['header']['eventType'];
    final event = jsonRequest['event'];

    switch (eventType) {
      case 'message.receive.normal':
        _onMessageNormalSubscriber?.call(event);
        break;
      case 'message.receive.instruction':
        _onMessageInstructionSubscriber?.call(event);
        break;
      case 'group.join':
        _onGroupJoinSubscriber?.call(event);
        break;
      case 'group.leave':
        _onGroupLeaveSubscriber?.call(event);
        break;
      case 'bot.followed':
        _onBotFollowedSubscriber?.call(event);
        break;
      case 'bot.unfollowed':
        _onBotUnfollowedSubscriber?.call(event);
        break;
      case 'button.report.inline':
        _onButtonReportInlineSubscriber?.call(event);
        break;
    }
  }

  void onMessageNormal(Function(Map<dynamic, dynamic> event) func) {
    _onMessageNormalSubscriber = func;
  }

  void onMessageInstruction(Function(Map<dynamic, dynamic> event) func) {
    _onMessageInstructionSubscriber = func;
  }

  void onGroupJoin(Function(Map<dynamic, dynamic> event) func) {
    _onGroupJoinSubscriber = func;
  }

  void onGroupLeave(Function(Map<dynamic, dynamic> event) func) {
    _onGroupLeaveSubscriber = func;
  }

  void onBotFollowed(Function(Map<dynamic, dynamic> event) func) {
    _onBotFollowedSubscriber = func;
  }

  void onBotUnfollowed(Function(Map<dynamic, dynamic> event) func) {
    _onBotUnfollowedSubscriber = func;
  }

  void onButtonReportInline(Function(Map<dynamic, dynamic> event) func) {
    _onButtonReportInlineSubscriber = func;
  }
}
