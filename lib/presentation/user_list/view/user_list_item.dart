import 'package:flutter/material.dart';

import '../../../domain/model/user_model.dart';

class UserListItem extends StatelessWidget {
  final UserModel user;

  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(user.avatar),
        ),
        title: Text(
          '${user.firstName} ${user.lastName}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          user.email,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        onTap: () {
          // Handle the tap event
        },
      ),
    );
  }
}
