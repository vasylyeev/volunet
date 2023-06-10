import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constraints/style.dart';
import '../widgets/category_button.dart';

class CategoryChooser extends StatefulWidget {
  const CategoryChooser({Key? key}) : super(key: key);

  @override
  State<CategoryChooser> createState() => _CategoryChooserState();
}

class _CategoryChooserState extends State<CategoryChooser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      color: AppStyle.colors.backgroundGrey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
        scrollDirection: Axis.horizontal,
        children: [
          CategoryButton(
            icon: const Icon(Ionicons.home),
            name: 'Житло',
          ),
          CategoryButton(
            icon: const Icon(Ionicons.fast_food),
            name: 'Продукти',
          ),
          CategoryButton(
            icon: const Icon(Ionicons.paw),
            name: 'Тварини',
            isSelected: true,
          ),
          CategoryButton(
            icon: const Icon(Ionicons.medkit),
            name: 'Медична Допомога',
          ),
          CategoryButton(
            icon: const Icon(Ionicons.ellipsis_horizontal),
            name: 'Щось',
          ),
          CategoryButton(
            icon: const Icon(Ionicons.ellipsis_horizontal),
            name: 'Щось',
          ),
        ],
      ),
    );
  }
}
