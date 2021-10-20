abstract class UsersListEvent {}

class OpenScreenUsersListEvent extends UsersListEvent {}

class UpdateUsersListEvent extends UsersListEvent {}

class SearchToUsersListEvent extends UsersListEvent {
  String searchText;

  SearchToUsersListEvent(this.searchText);
}