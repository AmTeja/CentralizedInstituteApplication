import 'package:cia/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintForm extends StatelessWidget {
  const ComplaintForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComplaintsCubit, ComplaintsState>(
      listener: (context, state) {
        if(state.status == ComplaintStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(state.errorMessage.toString())));
        }
        if(state.status == ComplaintStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color(0xFF295BE9),
              content: Text("Your complaint has been submitted!", style: TextStyle(color: Colors.white),)));
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Form(
          child: Column(
            children: const [
              _TitleInput(),
              SizedBox(height: 20.0,),
              _DescriptionInput()
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleInput extends StatelessWidget {
  const _TitleInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ComplaintsCubit, ComplaintsState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return TextFormField(
          onChanged: (title) => context.read<ComplaintsCubit>().titleChanged(title),
          cursorColor: Colors.white,
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(color: Colors.white),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              hintText: "Title",
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.75)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              )
          ),
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintsCubit, ComplaintsState>(
        buildWhen: (previous, current) => previous.description != current.description,
        builder: (context, state){
          return TextFormField(
            maxLines: 7,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) => context.read<ComplaintsCubit>().descriptionChanged(value),
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "Description",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.75)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                )
            ),
          );
        });
  }
}