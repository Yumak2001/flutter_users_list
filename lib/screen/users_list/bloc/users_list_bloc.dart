

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_list/models/user.dart';
import 'package:flutter_users_list/screen/users_list/bloc/users_list_event.dart';
import 'package:flutter_users_list/screen/users_list/bloc/users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  UsersListBloc() : super(LoadingUsersListState());

  final List<User> listUsers = [];

  @override
  Stream<UsersListState> mapEventToState(UsersListEvent event) async* {
    if (event is OpenScreenUsersListEvent) {
      yield LoadingUsersListState();
      bool result = await getUsersFromApi();
      if (result) {
        yield ViewUsersListState(listUsers);
      } else {
        yield ErrorViewUsersListState('Не удалось получить список пользователей.');
      }
    } else if (event is UpdateUsersListEvent) {
      yield LoadingUsersListState();
      bool result = await getUsersFromApi();
      if (result == false) {
        yield ErrorViewUsersListState('Не удалось обновить список пользователей.');
        await Future.delayed(const Duration(seconds: 3));
      }
      yield ViewUsersListState(listUsers);
    } else if (event is SearchToUsersListEvent) {
      Iterable<User> newList = listUsers.where((element) =>
        event.searchText.isEmpty ||
        element.name.first.toLowerCase().contains(event.searchText)
      );
      if (newList.isNotEmpty) {
        yield ViewUsersListState(newList.toList());
      } else {
        yield ErrorViewUsersListState("Поиск не дал результата");
      }
    }
  }

  getUsersFromApi() async {
    int length = 30;
    String url = 'https://randomuser.me/api/?results=$length';
    List<User> newList = [];
    try {
      var response = await Dio().get(url);
      List<dynamic> res = response.data['results'];
      for (var element in res) {
        newList.add(User.fromJson(element));
      }
      try {
        listUsers.removeRange(0, listUsers.length);
      } catch (e) {
        log(e.toString());
      }
      listUsers.addAll(newList);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

}