import 'package:cia/config/routes.dart';
import 'package:cia/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static Route route() {
    return fadeRoute(const ProfileScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.1),
            const ProfileHeader(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Expanded(child: ExpansionList())
          ],
        ),
      ),
    );
  }
}


