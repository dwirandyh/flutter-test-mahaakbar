import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../data/repository/user_repository.dart';
import '../../../domain/model/user_model.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserRepository userRepository;
  final int itemPerPages = 6;

  UserListBloc({required this.userRepository}) : super(const UserListState()) {
    on<UserListFetched>(_onUserFetched);
  }

  void _onUserFetched(
      UserListFetched event, Emitter<UserListState> emit) async {
    if (state.status == UserListStatus.initial || !state.hasReachedMax) {
      try {
        if (state.status == UserListStatus.initial) {
          var users = <UserModel>[];
          users.addAll(await userRepository.getUsers(1));
          users.addAll(await userRepository.getUsers(2));
          emit(state.copyWith(
            status: UserListStatus.success,
            users: users,
            hasReachedMax: false,
          ));
        } else {
          final users = await userRepository
              .getUsers(state.users.length ~/ itemPerPages + 1);
          emit(
            users.isEmpty
                ? state.copyWith(hasReachedMax: true)
                : state.copyWith(
                    status: UserListStatus.success,
                    users: List.of(state.users)..addAll(users),
                    hasReachedMax: false,
                  ),
          );
        }
      } catch (_) {
        emit(state.copyWith(status: UserListStatus.failure));
      }
    }
  }
}
