part of 'user_list_bloc.dart';

sealed class UserListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class UserListFetched extends UserListEvent {}
