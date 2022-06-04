import 'package:flutter/material.dart';

class RequestChangesButton extends StatelessWidget {
  const RequestChangesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 32.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)
            ),
            elevation: 4,
            primary: Colors.white,
            onPrimary: const Color(0xFF295BE9),
            minimumSize: const Size(237, 71),
            maximumSize: const Size(237, 71),
          ),
          onPressed: () {}, child: Text("Request Changes", style: Theme.of(context).textTheme.headline3!
          .copyWith(color: const Color(0xFF295BE9)),)),
    );
  }
}
