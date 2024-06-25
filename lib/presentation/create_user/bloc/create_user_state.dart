part of 'create_user_bloc.dart';

@immutable
sealed class CreateUserState extends Equatable {}

final class CreateUserInitial extends CreateUserState {
  @override
  List<Object?> get props => [];
}

final class CreateUserLoading extends CreateUserState {
  @override
  List<Object?> get props => [];
}

final class CreateUserSuccess extends CreateUserState {
  final CreatedUserModel user;

  CreateUserSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class CreateUserFailure extends CreateUserState {
  final String error;

  CreateUserFailure({required this.error});

  @override
  List<Object> get props => [error];
}
