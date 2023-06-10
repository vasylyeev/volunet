import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constraints/style.dart';

class NewPostInput extends StatefulWidget {
  bool withPublishButton;
  NewPostInput({Key? key, this.withPublishButton = false}) : super(key: key);

  @override
  State<NewPostInput> createState() => _NewPostInputState();
}

class _NewPostInputState extends State<NewPostInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Ionicons.pencil_outline,
        ),
        hintText: 'Про що хочете написати?',
        contentPadding: const EdgeInsets.all(0),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        suffixIcon: widget.withPublishButton ? Container(
          margin: const EdgeInsets.only(right: 12),
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Опублікувати',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppStyle.colors.darkBlue,
              ),
            ),
          ),
        ) : null,
      ),
    );
  }
}
