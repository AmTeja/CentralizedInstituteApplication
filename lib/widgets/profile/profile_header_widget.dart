import 'package:cia/blocs/blocs.dart';
import 'package:cia/models/models.dart';
import 'package:cia/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if(state is ProfileLoading) {
          return const Center(child:  CircularProgressIndicator(),);
        }
        if(state is ProfileLoaded) {
          StudentProfile profile = state.studentProfile;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ProfileBox(),
              const SizedBox(height: 16.0,),
              Text("${profile.firstName} ${profile.middleName ?? ""} ${profile.lastName ?? ""}",
                style: Theme.of(context).textTheme.headline3,),
              const SizedBox(height: 8.0,),
              Text(profile.rollNo, style: Theme.of(context).textTheme.headline5,),
              const SizedBox(height: 4.0,),
              Text(profile.phoneNo!, style: Theme.of(context).textTheme.headline5,),
              const SizedBox(height: 4.0,),
              Text(profile.email!, style: Theme.of(context).textTheme.headline5,),
              const SizedBox(height: 8.0,),
              const ChangePasswordButton()
            ],
          );
        }
         return const Center(child: Text("Something went wrong!"),);
      },
    );
  }
}
