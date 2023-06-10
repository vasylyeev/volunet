import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constraints/style.dart';

class AddImageButton extends StatelessWidget {
  const AddImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppStyle.colors.lightGrey,
        minimumSize: const Size(double.infinity, 200),
      ),
      child: Icon(
        Ionicons.image_outline,
        color: AppStyle.colors.darkGrey,
      ),
    );
  }
}
