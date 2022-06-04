import 'package:cia/config/routes.dart';
import 'package:flutter/material.dart';

class ComplaintsAndQueriesScreen extends StatelessWidget {

  static Route route() {
    return fadeRoute(const ComplaintsAndQueriesScreen());
  }

  const ComplaintsAndQueriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF295BE9),
      ),
      body: ListView(
        children: [
          Container(
            height: 240,
            color: const Color(0xFF295BE9),
          ),
        ],
      ),
    );
  }
}
