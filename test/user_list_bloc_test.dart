import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_collection/data/repository/user_repository.dart';
import 'package:user_collection/domain/model/user_model.dart';
import 'package:user_collection/presentation/user_list/bloc/user_list_bloc.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('UserListBloc', () {
    late UserListBloc userListBloc;
    late MockUserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
      userListBloc = UserListBloc(userRepository: userRepository);
    });

    tearDown(() {
      userListBloc.close();
    });

    test('initial state is UserListState', () {
      expect(userListBloc.state, const UserListState());
    });

    blocTest<UserListBloc, UserListState>(
      'emits [success] when UserListFetched is added and data is loaded successfully',
      build: () {
        when(() => userRepository.getUsers(1)).thenAnswer((_) async => [
              const UserModel(
                  id: 1,
                  email: 'test1@example.com',
                  firstName: 'John',
                  lastName: 'Doe',
                  avatar: ''),
              const UserModel(
                  id: 2,
                  email: 'test2@example.com',
                  firstName: 'Jane',
                  lastName: 'Smith',
                  avatar: ''),
            ]);
        when(() => userRepository.getUsers(2)).thenAnswer((_) async => [
              const UserModel(
                  id: 3,
                  email: 'test3@example.com',
                  firstName: 'John',
                  lastName: 'Doe',
                  avatar: ''),
              const UserModel(
                  id: 4,
                  email: 'test4@example.com',
                  firstName: 'Jane',
                  lastName: 'Smith',
                  avatar: ''),
            ]);
        return userListBloc;
      },
      act: (bloc) => bloc.add(UserListFetched()),
      expect: () => [
        const UserListState(
            status: UserListStatus.success,
            users: [
              UserModel(
                  id: 1,
                  email: 'test1@example.com',
                  firstName: 'John',
                  lastName: 'Doe',
                  avatar: ''),
              UserModel(
                  id: 2,
                  email: 'test2@example.com',
                  firstName: 'Jane',
                  lastName: 'Smith',
                  avatar: ''),
              UserModel(
                  id: 3,
                  email: 'test3@example.com',
                  firstName: 'John',
                  lastName: 'Doe',
                  avatar: ''),
              UserModel(
                  id: 4,
                  email: 'test4@example.com',
                  firstName: 'Jane',
                  lastName: 'Smith',
                  avatar: ''),
            ],
            hasReachedMax: false),
      ],
    );

    blocTest<UserListBloc, UserListState>(
      'emits [failure] when UserListFetched is added and data loading fails',
      build: () {
        when(() => userRepository.getUsers(1))
            .thenThrow(Exception('Failed to load users'));
        return userListBloc;
      },
      act: (bloc) => bloc.add(UserListFetched()),
      expect: () => [
        const UserListState(status: UserListStatus.failure),
      ],
    );

    blocTest<UserListBloc, UserListState>(
      'does not emit new state when UserListFetched is added and state hasReachedMax is true',
      build: () {
        return userListBloc
          ..emit(const UserListState(
              status: UserListStatus.success, users: [], hasReachedMax: true));
      },
      act: (bloc) => bloc.add(UserListFetched()),
      expect: () => [],
    );
  });
}
