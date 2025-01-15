part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeChatHistoryEvent extends HomeEvent {
  final String usrMsg;
  final String title;
  final List<ChatHistoryList> chatHistoryList;

  HomeChatHistoryEvent(this.usrMsg, this.title, this.chatHistoryList);
}
