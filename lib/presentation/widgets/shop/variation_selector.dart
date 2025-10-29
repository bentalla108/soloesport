// lib/presentation/widgets/shop/variation_selector.dart
import 'package:flutter/material.dart';
import '../../../core/constants/app-theme.dart';

class VariationSelector extends StatelessWidget {
  final String name;
  final List<String> options;
  final String selectedOption;
  final Function(String) onSelected;

  const VariationSelector({
    Key? key,
    required this.name,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$name :',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              options.map((option) {
                final bool isSelected = option == selectedOption;
                return GestureDetector(
                  onTap: () => onSelected(option),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppColors.primaryColor
                              : AppColors.surfaceColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color:
                            isSelected
                                ? AppColors.primaryColor
                                : AppColors.textSecondaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        color:
                            isSelected
                                ? Colors.white
                                : AppColors.textSecondaryColor,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
