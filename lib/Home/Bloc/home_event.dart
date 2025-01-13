part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeChatHistoryEvent extends HomeEvent {
  final String usrMsg;

  HomeChatHistoryEvent(this.usrMsg);
}
