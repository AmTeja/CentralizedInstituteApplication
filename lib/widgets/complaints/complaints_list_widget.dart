import 'package:cia/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cia/blocs/blocs.dart';
import 'package:intl/intl.dart';

class ComplaintsList extends StatelessWidget {
  const ComplaintsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintsBloc, ComplaintsState>(
      builder: (context, state) {
        if(state is ComplaintsLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }
        if(state is ComplaintsLoaded) {
          return _List(complaints: state.complaints);
        }
        return const Center(child: Text("Something went wrong!"),);
      },
    );
  }
}

class _List extends StatelessWidget {

  final List<Complaint> complaints;

  const _List({Key? key, required this.complaints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return complaints.isEmpty
        ? const Center(child: Text("No complaints have been filed by you!"),)
        : Column(
      children: complaints.map((Complaint complaint) {
        return _ComplaintTile(complaint: complaint);
      }).toList(),
    );
  }
}

class _ComplaintTile extends StatelessWidget {
  
  final Complaint complaint;
  const _ComplaintTile({Key? key, required this.complaint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Material(
        elevation: 4,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          color: Colors.white,
          child: ListTile(
            title: Text(complaint.title,  style: Theme.of(context).textTheme.headline3,),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(complaint.description, style: Theme.of(context).textTheme.headline5,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    height: 40,
                    width: 111,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: complaint.resolved
                                ? const Color(0xFF50B432)
                                : const Color(0xFFFF006E)
                        )
                    ),
                    child: complaint.resolved
                        ? Text("SOLVED", style: Theme.of(context).textTheme.headline5!.copyWith(color: const Color(0xFF50B432)),)
                        : Text("PENDING", style: Theme.of(context).textTheme.headline5!.copyWith(color: const Color(0xFFFF006E)),),
                  ),
                )
              ],
            ),
            trailing: Text(DateFormat('yMMMd').format(complaint.filedOn)),
          ),
        ),
      ),
    );
  }
}


