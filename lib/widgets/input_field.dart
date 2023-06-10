import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:volunet/constraints/style.dart';

class InputField extends StatefulWidget {
  bool withSearchIcon;
  final String text;
  final bool withButton;

  InputField({Key? key, this.withSearchIcon = false, required this.text, required this.withButton})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: widget.withSearchIcon ? const Icon(Ionicons.search_outline) : null,
        suffixIcon: widget.withButton
            ? Container(
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
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        hintText: widget.text,
        filled: true,
        fillColor: AppStyle.colors.lightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
