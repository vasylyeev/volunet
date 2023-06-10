import 'package:flutter/material.dart';

import '../constraints/style.dart';

class CategoryButton extends StatelessWidget {
  bool isSelected;
  final Widget icon;
  final String name;

  CategoryButton(
      {Key? key,
      this.isSelected = false,
      required this.icon,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 24),
      child: Column(
        children: [
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppStyle.colors.darkBlue : Colors.white,
            ),
            child: IconButton(
              onPressed: () {},
              icon: icon,
              color: isSelected ? Colors.white : AppStyle.colors.darkGrey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? AppStyle.colors.darkBlue : AppStyle.colors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }
}
