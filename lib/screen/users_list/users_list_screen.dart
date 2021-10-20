import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_list/hive_common.dart';
import 'package:flutter_users_list/models/user.dart';
import 'package:flutter_users_list/screen/login/bloc/login_bloc.dart';
import 'package:flutter_users_list/screen/login/bloc/login_event.dart';
import 'package:flutter_users_list/screen/login/login_screen.dart';
import 'package:flutter_users_list/screen/users_list/bloc/search_bloc.dart';
import 'package:flutter_users_list/screen/users_list/bloc/search_event.dart';
import 'package:flutter_users_list/screen/users_list/bloc/users_list_bloc.dart';
import 'package:flutter_users_list/screen/users_list/bloc/users_list_event.dart';
import 'package:flutter_users_list/screen/users_list/user_card_fragment.dart';

import 'bloc/search_state.dart';
import 'bloc/users_list_state.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final _searchTextFormFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        return Scaffold(
          appBar: (state is EnabledSearchState) ?
            _appBar(true):
            _appBar(false),
          body: BlocBuilder<UsersListBloc, UsersListState>(
            builder: (BuildContext context, UsersListState state) {
              if (state is LoadingUsersListState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ViewUsersListState) {
                List<User> usersList = state.usersList.cast<User>();
                return RefreshIndicator(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    slivers: <Widget>[
                      SliverPadding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return UserCardFragment(user: usersList[index]);
                            },
                            childCount: usersList.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onRefresh: () async {
                    context.read<UsersListBloc>().add(UpdateUsersListEvent());
                  },
                );
              } else if (state is ErrorViewUsersListState) {
                return RefreshIndicator(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Column(
                              children: [
                                const SizedBox(height: 80,),
                                Text(
                                  state.msgError,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                    ],
                  ),
                  onRefresh: () async {
                    context.read<UsersListBloc>().add(UpdateUsersListEvent());
                  },
                );
              } else {
                return const Center();
              }
            },
          ),
        );
      },
    );
  }

  AppBar _appBar(bool searchEnabled) {
    if (searchEnabled) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: "Назад",
          onPressed: () {
            _searchTextFormFieldController.clear();
            context.read<SearchBloc>().add(DisabledSearchEvent());
          },
        ),
        title: TextField(
          decoration: const InputDecoration(
            hintText: "Поиск...",
          ),
          controller: _searchTextFormFieldController,
          maxLines: 1,
          onChanged: (text) {
            context.read<UsersListBloc>().add(SearchToUsersListEvent(text));
          },
          textInputAction: TextInputAction.search,
        ),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.search),
          tooltip: "Поиск",
          onPressed: () {
            context.read<SearchBloc>().add(EnabledSearchEvent());
          },
        ),
        title: Text(
          getUsername().toString(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _logOut();
            },
            tooltip: "Выйти",
            icon: const Icon(
                Icons.logout_rounded
            ),
          ),
        ],
      );
    }
  }

  _logOut() {
    deleteUsername();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BlocProvider<LoginBloc>(
      create: (_) => LoginBloc()..add(InitLoginEvent()),
      child: const LoginScreen(),
    )));
  }

}
