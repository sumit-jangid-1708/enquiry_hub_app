import 'package:flutter/material.dart';
import '../color/app_color.dart';

class FilterChipWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipWidget({
    super.key,
    required this.title,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.kColorAccent.withOpacity(0.1) : AppColor.whiteColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColor.kColorAccent : AppColor.cardBorderColor,
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColor.kColorAccent : AppColor.kColorTextSecondary,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
