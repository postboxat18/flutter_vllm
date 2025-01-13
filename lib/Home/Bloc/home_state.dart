part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeChatHistory extends HomeState {
  final List<ChatHistoryList> chatHistoryList;

  HomeChatHistory(this.chatHistoryList);
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {}
