import 'package:cia/blocs/blocs.dart';
import 'package:cia/models/models.dart';
import 'package:cia/widgets/profile/expansion_list/academic_expandable.dart';
import 'package:cia/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpansionList extends StatefulWidget {
  const ExpansionList({Key? key}) : super(key: key);

  @override
  State<ExpansionList> createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ExpansionList> {

  List<ExpansionItem> items = [
    ExpansionItem(headerValue: 'Bio', headerIcon: Icons.person, tag: 'bioItem'),
    ExpansionItem(headerValue: 'Academic Details', headerIcon: Icons.school_rounded, tag: 'schoolItem'),
    ExpansionItem(headerValue: 'Fee Details', headerIcon: Icons.card_membership, tag: 'feeItem'),
    ExpansionItem(headerValue: 'Counselling Details', headerIcon: Icons.supervisor_account_sharp, tag: 'counsellingItem'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if(state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }
        if(state is ProfileLoaded) {
          return ListView(
            shrinkWrap: true,
            children: [
              ExpansionPanelList(
                elevation: 0,
                expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 4.0),
                dividerColor: Colors.transparent,
                expansionCallback: (index, expanded) {
                  setState(() {
                    items[index].isExpanded =!expanded;
                  });
                },
                children: items.map((item) {
                  if(item.tag == 'bioItem') {
                    item.expandedWidget = BioExpandable(context: context, bio: state.studentProfile.bio!);
                  }
                  if(item.tag == 'schoolItem') {
                    item.expandedWidget = AcademicExpandable(context: context, education: state.studentProfile.education!);
                  }
                  return ExpansionPanel(
                      canTapOnHeader: true,
                      backgroundColor: item.isExpanded
                          ? Colors.white
                          : Colors.transparent,
                      isExpanded: item.isExpanded,
                      headerBuilder: (context, isExpanded) {
                        return ExpansionHeader(
                            expansionItem: item,
                            );
                      },
                      body: item.expandedWidget == null ?  Container(
                        height: 240,
                        color: Colors.white,
                      ) : item.expandedWidget!
                  );
                }).toList()
              ),
              const RequestChangesButton()
            ],
          );
        }
        return const Center(
          child: Text("Something went wrong!"),
        );
      },
    );
  }
}
