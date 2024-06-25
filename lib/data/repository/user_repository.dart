import 'package:dio/dio.dart';
import 'package:user_collection/domain/model/created_user_model.dart';

import '../../domain/model/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers(int page);
  Future<CreatedUserModel> createUser(String name, String job);
}

class UserRepositoryImpl extends UserRepository {
  final Dio dio;
  final String baseUrl = 'https://reqres.in/api/users';

  UserRepositoryImpl({required this.dio});

  @override
  Future<List<UserModel>> getUsers(int page) async {
    final response = await dio.get(baseUrl, queryParameters: {'page': page});
    if (response.statusCode == 200) {
      final data = response.data;
      final List<dynamic> users = data['data'];
      return users.map((rawUser) {
        return UserModel(
          id: rawUser['id'],
          email: rawUser['email'],
          firstName: rawUser['first_name'],
          lastName: rawUser['last_name'],
          avatar: rawUser['avatar'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<CreatedUserModel> createUser(String name, String job) async {
    final response = await dio.post(
      baseUrl,
      data: {'name': name, 'job': job},
    );
    if (response.statusCode == 201) {
      final data = response.data;
      return CreatedUserModel.fromJson(data);
    } else {
      throw Exception('Failed to create user');
    }
  }
}
