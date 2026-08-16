import 'package:flutter/material.dart';
import 'package:saranya_rajagopalan_todo_app/core/colors.dart';

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool showBackButton;

  const WidgetAppBar({
    super.key,
    required this.title,
    required this.backgroundColor,
    this.onBackPressed,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      surfaceTintColor: AppColors.transparent,
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? IconButton(
              onPressed: onBackPressed ?? () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back_rounded, color: AppColors.navy),
              tooltip: 'Back',
            )
          : null,
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: AppColors.navy,
          fontWeight: FontWeight.w800,
          fontSize: 17,
          letterSpacing: 0.8,
        ),
      ),
      actions: actions,
    );
  }
}
