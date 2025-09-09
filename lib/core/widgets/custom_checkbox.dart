import 'package:flutter/material.dart';
import 'package:synctrackr/core/constants/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 16,
        height: 16,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDark ? Color(0xff325A72) : AppColors.background,
          border: Border.all(
            color: isDark ? AppColors.darkPrimaryBlue : AppColors.darkAdmin,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: value
            ? Icon(
                Icons.check,
                size: 10,
                color: Colors.blue,
              )
            : null,
      ),
    );
  }
}
