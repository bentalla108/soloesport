// lib/presentation/widgets/tournaments/rule_item.dart
import 'package:flutter/material.dart';
import '../../../core/constants/app-theme.dart';

class RuleItem extends StatelessWidget {
  final String rule;
  final bool isLast;

  const RuleItem({Key? key, required this.rule, this.isLast = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.secondaryColor,
            size: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              rule,
              style: const TextStyle(
                color: AppColors.textPrimaryColor,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
