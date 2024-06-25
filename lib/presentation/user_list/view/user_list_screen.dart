import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'user_list_view.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User List'),
        ),
        body: UserListView.create(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push('/add');
          },
          child: const Icon(Icons.add),
        ));
  }
}
