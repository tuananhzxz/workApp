import 'package:flutter/material.dart';
import 'package:workspace/Values/app_font.dart';

class textfield extends StatelessWidget {
  const textfield(
      {super.key, required this.hint, this.icon, required this.textCTL,this.press});

  final String hint;
  final IconData? icon;
  final TextEditingController textCTL;
  final Function(String)? press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: TextFormField(
            style: MyFont.h5,
            onChanged: press,
              controller: textCTL,
              maxLines: null,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                icon: Icon(icon),
              )
            ),
        ),
      ],
    );
  }
}
