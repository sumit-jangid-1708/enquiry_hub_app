import 'package:flutter/material.dart';
import '../color/app_color.dart';

class VentureCard extends StatelessWidget {
  final String name;
  final String? logo;
  final Color? color;
  final VoidCallback? onTap;
  final bool isSelected;

  const VentureCard({
    super.key,
    required this.name,
    this.logo,
    this.color,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? (color ?? AppColor.kColorAccent) : AppColor.cardBorderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: (color ?? AppColor.kColorPrimary).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: (logo != null && logo!.isNotEmpty)
                    ? Image.asset(
                        logo!,
                        height: 24,
                        width: 24,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.business_center_outlined,
                          color: color ?? AppColor.kColorPrimary,
                          size: 20,
                        ),
                      )
                    : Icon(
                        Icons.business_center_outlined,
                        color: color ?? AppColor.kColorPrimary,
                        size: 20,
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: AppColor.kColorTextPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
