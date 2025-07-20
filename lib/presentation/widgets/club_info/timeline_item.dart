// lib/presentation/widgets/club_info/timeline_item.dart
import 'package:flutter/material.dart';
import 'package:soloesport/core/constants/app-theme.dart';

class TimelineItem extends StatelessWidget {
  final String year;
  final String title;
  final String description;
  final bool isFirst;
  final bool isLast;

  const TimelineItem({
    Key? key,
    required this.year,
    required this.title,
    required this.description,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline axis
        Column(
          children: [
            // Top line (hidden for first item)
            if (!isFirst)
              Container(width: 2, height: 16, color: AppColors.accentColor),

            // Circle
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentColor.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            // Bottom line (hidden for last item)
            if (!isLast)
              Container(width: 2, height: 50, color: AppColors.accentColor),
          ],
        ),

        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Year
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    year,
                    style: const TextStyle(
                      color: AppColors.textSecondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Title and description
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
