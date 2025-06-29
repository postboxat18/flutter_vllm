part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeChatHistoryEvent extends HomeEvent {
  final String usrMsg;
  final String title;
  final String uuid_name;
  final List<ChatHistoryList> chatHistoryList;

  HomeChatHistoryEvent(this.usrMsg, this.title,this.uuid_name, this.chatHistoryList);
}
