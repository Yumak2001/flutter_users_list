import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_list/hive_common.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginBloc() : super(LoadingLoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is InitLoginEvent) {
      yield LoadingLoginState();
      String? username = getUsername();
      if (username == '') {
        yield InitLoginState();
      } else {
        yield LoggedInLoginState();
      }
    } else if (event is ValidateLoginEvent) {
      yield LoadingLoginState();
      String _username = event.username;
      if (_username.length < 4) {
        yield ValidationErrorLoginState("Длина логина должна быть не менее 4 символов");
      } else {
        setUsername(_username);
        yield LoggedInLoginState();
      }
    }
  }


}