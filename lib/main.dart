import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_list/screen/login/bloc/login_bloc.dart';
import 'package:flutter_users_list/screen/login/bloc/login_event.dart';
import 'package:flutter_users_list/screen/login/login_screen.dart';

import 'hive_common.dart';

void main() async {
  await initHive();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: BlocProvider<LoginBloc>(
        create: (_) => LoginBloc()..add(InitLoginEvent()),
        child: const LoginScreen(),
      ),
    );
  }
}
