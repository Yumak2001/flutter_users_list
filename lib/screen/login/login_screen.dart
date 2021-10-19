import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

import '../../hive_common.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login to Random users list"),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is InitLoginState) {
            _loginFormFieldController.clear();
          } else if (state is LoggedInLoginState) {
            log("LoggedIn");
          } else if (state is ValidationErrorLoginState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                state.errorMsg,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (BuildContext context, LoginState state) {
          if (state is LoadingLoginState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is InitLoginState || state is ValidationErrorLoginState) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextField(
                        decoration: const InputDecoration(
                          hintText: "Введите логин",
                        ),
                        controller: _loginFormFieldController,
                        maxLength: 32,
                        maxLines: 1,
                        onSubmitted: (event) {
                          _buttonLogin(context.read<LoginBloc>());
                        },
                        textInputAction: TextInputAction.send,
                      ),
                      TextButton(
                        onPressed: () {
                          _buttonLogin(context.read<LoginBloc>());
                        },
                        child: const Text("Войти!"),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: TextButton(
                onPressed: () {
                  deleteUsername();
                  context.read<LoginBloc>().add(InitLoginEvent());
                },
                child: const Text("Выйти"),
              ),
            );
          }
        },
      ),
    );
  }

  _buttonLogin(LoginBloc bloc) {
    bloc.add(ValidateLoginEvent(_loginFormFieldController.value.text));
  }
}