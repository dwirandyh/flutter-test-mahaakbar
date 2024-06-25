import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/create_user_bloc.dart';

class UserFormView extends StatefulWidget {
  const UserFormView({super.key});

  @override
  State<UserFormView> createState() => _UserFormViewState();
}

class _UserFormViewState extends State<UserFormView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateUserBloc, CreateUserState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jobController,
                decoration: const InputDecoration(labelText: 'Job'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Job cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              state is CreateUserLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<CreateUserBloc>().add(
                                CreateUserButtonPressed(
                                  name: _nameController.text,
                                  job: _jobController.text,
                                ),
                              );
                        }
                      },
                      child: const Text('Create User'),
                    ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    super.dispose();
  }
}
