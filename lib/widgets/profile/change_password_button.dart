import 'package:flutter/material.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: const Color(0xFF295BE9),
            elevation: 4,
            minimumSize: const Size(166, 38),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            )
        ),
        onPressed: () {},
        child: const Text("Change Password", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      )
    );
  }
}
