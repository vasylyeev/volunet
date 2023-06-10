import 'package:flutter/material.dart';

import '../constraints/style.dart';

class NewPostCategoryButton extends StatelessWidget {
  bool isSelected;
  final IconData icon;
  final String name;

  NewPostCategoryButton(
      {Key? key,
      this.isSelected = false,
      required this.icon,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isSelected ? AppStyle.colors.darkBlue : Colors.white,
        borderRadius: AppStyle.borderRadius,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : AppStyle.colors.darkGrey,
              size: 26,
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : AppStyle.colors.darkGrey,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
