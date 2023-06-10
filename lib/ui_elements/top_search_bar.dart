import 'package:flutter/material.dart';

import '../widgets/input_field.dart';

class TopSearchBar extends StatefulWidget {
  const TopSearchBar({Key? key}) : super(key: key);

  @override
  State<TopSearchBar> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            InputField(
              withSearchIcon: true,
              text: 'Знайти профіль...',
              withButton: false,
            ),
          ],
        ),
      ),
    );
  }
}
