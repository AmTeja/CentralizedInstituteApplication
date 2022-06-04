import 'package:cia/blocs/blocs.dart';
import 'package:cia/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBox extends StatelessWidget {
  const ProfileBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Hero(
      tag: "profileBoxTag",
      child: Container(
        height: 57,
        width: 57,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(14.0),
            image: user.photo == null
                ? null
                : DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(user.photo!))),
        child: user.photo != null
            ? null
            : const Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
