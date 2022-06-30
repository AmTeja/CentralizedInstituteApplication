import 'package:flutter/material.dart';

class HomepageSearchBox extends StatelessWidget {
  const HomepageSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8.0),
        child: TextFormField(
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Search Now',
              hintStyle: const TextStyle(fontFamily: 'Nirmala', fontSize: 18.0, color: Color(0xFFB1B6C6)),
              prefixIcon: const Icon(Icons.search,
                size: 28.0,
                color: Color(0xFFB1B6C6),),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0)
              )
          ),
        ),
      ),
    );
  }
}
