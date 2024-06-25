import 'package:flutter/material.dart';
import 'package:user_collection/domain/model/created_user_model.dart';

class CreatedUserView extends StatelessWidget {
  final CreatedUserModel user;

  const CreatedUserView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'User Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Divider(
          color: Colors.grey[400],
          height: 20,
          thickness: 1,
        ),
        Text(
          'User ID: ${user.id}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Name: ${user.name}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'Job: ${user.job}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        if (user.createdAt != null) ...[
          Text(
            'Created At: ${user.createdAt?.toString()}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
