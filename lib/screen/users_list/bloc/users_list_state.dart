import 'package:flutter_users_list/models/user.dart';

abstract class UsersListState {}

class LoadingUsersListState extends UsersListState {}

class ViewUsersListState extends UsersListState {
  List<User> usersList = [];

  ViewUsersListState(this.usersList);
}

class ErrorViewUsersListState extends UsersListState {
  String msgError;

  ErrorViewUsersListState(this.msgError);
}
