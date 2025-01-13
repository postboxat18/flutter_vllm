part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeChatHistory extends HomeState {
  final List<ChatHistoryList> chatHistoryList;
  final String title;
  HomeChatHistory(this.chatHistoryList, this.title);
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {}
