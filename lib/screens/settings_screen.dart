import 'package:cia/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text("Login"),
          trailing: Icon(Icons.logout),
          onTap: () {
            context.read<AppBloc>().add(AppLogoutRequested());
          },
        )
      ],
    );
  }
}
