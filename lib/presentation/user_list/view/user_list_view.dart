import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/user_repository.dart';
import '../bloc/user_list_bloc.dart';
import 'user_list_item.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  static Widget create() {
    final UserRepository userRepository = UserRepositoryImpl(dio: Dio());
    return BlocProvider(
      create: (context) =>
          UserListBloc(userRepository: userRepository)..add(UserListFetched()),
      child: const UserListView(),
    );
  }

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserListBloc, UserListState>(
      builder: (context, state) {
        switch (state.status) {
          case UserListStatus.failure:
            return const Center(child: Text('failed to fetch users'));
          case UserListStatus.success:
            if (state.users.isEmpty) {
              return const Center(child: Text('no users'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.users.length
                    ? _loadingIndicator()
                    : UserListItem(user: state.users[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.users.length
                  : state.users.length + 1,
              controller: _scrollController,
            );
          case UserListStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<UserListBloc>().add(UserListFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
