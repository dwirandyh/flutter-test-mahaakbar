import 'package:go_router/go_router.dart';
import 'package:user_collection/presentation/create_user/view/create_user_screen.dart';
import 'package:user_collection/presentation/user_list/view/user_list_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const UserListScreen(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => CreateUserScreen.create(),
    )
  ],
);
