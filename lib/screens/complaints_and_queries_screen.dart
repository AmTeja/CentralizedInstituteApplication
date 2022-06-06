import 'package:cia/config/routes.dart';
import 'package:cia/cubits/cubits.dart';
import 'package:cia/repositories/repositories.dart';
import 'package:cia/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintsAndQueriesScreen extends StatelessWidget {

  static Route route() {
    return fadeRoute(const ComplaintsAndQueriesScreen());
  }

  const ComplaintsAndQueriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF295BE9),
        ),
        body: BlocProvider(
          create: (_) => ComplaintsCubit(context.read<ComplaintsRepository>()),
          child: ListView(
            children: const [
              MakeComplaintBox(),
              ComplaintsList()
            ],
          ),
        ),
      ),
    );
  }
}