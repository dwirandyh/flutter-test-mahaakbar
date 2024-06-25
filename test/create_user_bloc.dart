import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_collection/data/repository/user_repository.dart';
import 'package:user_collection/domain/model/created_user_model.dart';
import 'package:user_collection/presentation/create_user/bloc/create_user_bloc.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group("CreateUserBloc", () {
    late CreateUserBloc createUserBloc;
    late MockUserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
      createUserBloc = CreateUserBloc(userRepository: userRepository);
    });

    tearDown(() {
      createUserBloc.close();
    });

    test('initial state is CreateUserInitial', () {
      expect(createUserBloc.state, CreateUserInitial());
    });

    blocTest<CreateUserBloc, CreateUserState>(
      'emits [CreateUserLoading, CreateUserSuccess] when CreateUserButtonPressed is added successfully',
      build: () {
        when(() => userRepository.createUser('John Doe', 'Developer'))
            .thenAnswer(
          (_) => Future.value(
            CreatedUserModel(id: 1, name: 'John Doe', job: 'Developer'),
          ),
        );
        return createUserBloc;
      },
      act: (bloc) =>
          bloc.add(CreateUserButtonPressed(name: 'John Doe', job: 'Developer')),
      expect: () => [
        CreateUserLoading(),
        CreateUserSuccess(
            user: CreatedUserModel(id: 1, name: 'John Doe', job: 'Developer')),
      ],
    );

    blocTest<CreateUserBloc, CreateUserState>(
      'emits [CreateUserLoading, CreateUserFailure] when createUser fails',
      build: () {
        when(() => userRepository.createUser(any(), any()))
            .thenThrow(Exception('Failed'));
        return createUserBloc;
      },
      act: (bloc) =>
          bloc.add(CreateUserButtonPressed(name: 'John Doe', job: 'Developer')),
      expect: () => [
        CreateUserLoading(),
        CreateUserFailure(error: 'Exception: Failed'),
      ],
    );
  });
}
