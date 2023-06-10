import 'package:flutter/material.dart';

import '../constraints/style.dart';

class BackTextButton extends StatelessWidget {
  final String text;

  const BackTextButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        '< $text',
        style: AppStyle.bigTextStyle,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
