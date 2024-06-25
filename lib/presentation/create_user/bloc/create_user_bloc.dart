import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_collection/domain/model/created_user_model.dart';

import '../../../data/repository/user_repository.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final UserRepository userRepository;

  CreateUserBloc({required this.userRepository}) : super(CreateUserInitial()) {
    on<CreateUserButtonPressed>(_onCreateUserButtonPressed);
  }

  void _onCreateUserButtonPressed(
      CreateUserButtonPressed event, Emitter<CreateUserState> emit) async {
    emit(CreateUserLoading());
    try {
      final user = await userRepository.createUser(event.name, event.job);
      emit(CreateUserSuccess(user: user));
    } catch (e) {
      emit(CreateUserFailure(error: e.toString()));
    }
  }
}
