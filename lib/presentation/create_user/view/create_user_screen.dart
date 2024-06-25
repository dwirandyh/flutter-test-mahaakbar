import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_collection/data/repository/user_repository.dart';
import 'package:user_collection/presentation/create_user/view/created_user_view.dart';
import 'package:user_collection/presentation/create_user/view/user_form_view.dart';

import '../bloc/create_user_bloc.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) => CreateUserBloc(
        userRepository: UserRepositoryImpl(
          dio: Dio(),
        ),
      ),
      child: const CreateUserScreen(),
    );
  }

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<CreateUserBloc, CreateUserState>(
            listener: (context, state) {
              if (state is CreateUserFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Failed to create user: ${state.error}')),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const UserFormView(),
                  BlocBuilder<CreateUserBloc, CreateUserState>(
                    builder: (context, state) {
                      if (state is CreateUserSuccess) {
                        return CreatedUserView(user: state.user);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
