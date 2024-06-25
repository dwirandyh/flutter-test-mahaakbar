part of 'create_user_bloc.dart';

@immutable
sealed class CreateUserEvent {}

class CreateUserButtonPressed extends CreateUserEvent {
  final String name;
  final String job;

  CreateUserButtonPressed({required this.name, required this.job});

  @override
  List<Object> get props => [name, job];
}
