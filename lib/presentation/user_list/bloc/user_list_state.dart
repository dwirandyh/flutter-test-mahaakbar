part of 'user_list_bloc.dart';

enum UserListStatus { initial, success, failure }

final class UserListState extends Equatable {
  const UserListState({
    this.status = UserListStatus.initial,
    this.users = const <UserModel>[],
    this.hasReachedMax = false,
  });

  final UserListStatus status;
  final List<UserModel> users;
  final bool hasReachedMax;

  UserListState copyWith({
    UserListStatus? status,
    List<UserModel>? users,
    bool? hasReachedMax,
  }) {
    return UserListState(
      status: status ?? this.status,
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''UserListState { status: $status, hasReachedMax: $hasReachedMax, users: ${users.length} }''';
  }

  @override
  List<Object> get props => [status, users, hasReachedMax];
}
