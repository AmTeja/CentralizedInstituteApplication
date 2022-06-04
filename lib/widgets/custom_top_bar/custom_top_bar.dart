import 'package:cia/blocs/blocs.dart';
import 'package:cia/config/theme.dart';
import 'package:cia/screens/screens.dart';
import 'package:cia/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopBar extends StatelessWidget {

  final bool isProfileLeading;

  const TopBar({
    Key? key,
    required this.isProfileLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProfileLoaded) {
          return ListTile(
            title: Hero(
              tag: "nameTag",
              child: Text(
                "${state.studentProfile.firstName} ${(state.studentProfile.middleName ?? '')} ${(state.studentProfile.lastName ?? '')}",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: secondaryTextColor),
              ),
            ),
            subtitle: Text(
              "${state.studentProfile.rollNo}\n${state.studentProfile.education!.branchCode}-${state.studentProfile.education!.section}",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: secondaryTextColor),
            ),
            trailing: isProfileLeading ? null : GestureDetector(
              onTap: () {
                Navigator.of(context).push(ProfileScreen.route());
              },
              child: const ProfileBox(),
            ),
            leading: !isProfileLeading ? null : GestureDetector(
                onTap: () {
                  Navigator.of(context).push(ProfileScreen.route());
                },
                child: const ProfileBox(),
          ));
        }
        return const Center(child: Text('Something went wrong!'));
      },
    );
  }
}

