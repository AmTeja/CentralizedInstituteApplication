import 'package:cia/cubits/cubits.dart';
import 'package:cia/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeComplaintBox extends StatelessWidget {
  const MakeComplaintBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintsCubit, ComplaintsState>(
      buildWhen: (previous, current) => previous.complaintBoxStatus != current.complaintBoxStatus,
      builder: (context, state) {
        bool expanded = state.complaintBoxStatus == ComplaintBoxStatus.expanded;
        return Container(
          height: expanded ? 540 : 240,
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
          color: const Color(0xFF295BE9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text("Complaints And Queries", style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white),),
              const SizedBox(height: 20.0,),
              Text("Facing any issues, Experiencing trouble?\nPost your issues to help us take action", style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white.withOpacity(0.8)),),
              SizedBox(height: expanded ? 20.0 : 0,),
              expanded ? const ComplaintForm() : Container(),
              const SizedBox(height: 20.0,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: const Color(0xFF295BE9),
                    fixedSize: const Size(244, 35)
                ),
                child: const Text("Add Your Complaint"),
                onPressed: () {
                  if(!expanded) {
                    return context.read<ComplaintsCubit>().complaintBoxSizeChanged(expanded);
                  }
                  context.read<ComplaintsCubit>().addComplaint();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}