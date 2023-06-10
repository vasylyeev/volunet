import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constraints/style.dart';

class BackToTopButton extends StatelessWidget {
  final ScrollController scrollController;
  bool showScrollToTopButton = false;
  BackToTopButton({Key? key, required this.scrollController, required this.showScrollToTopButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: showScrollToTopButton ? 1 : 0,
        child: FloatingActionButton(
          elevation: 0,
          focusColor: Colors.transparent,
          onPressed: () {
            if (scrollController.hasClients) {
              final position = scrollController.position.minScrollExtent;
              scrollController.animateTo(
                position,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
            }
          },
          backgroundColor: AppStyle.colors.darkBlue,
          child: const Icon(Ionicons.arrow_up),
        ),
      ),
    );
  }
}
