// lib/presentation/widgets/reservations/equipment_selection.dart
import 'package:flutter/material.dart';
import 'package:soloesport/core/constants/app-theme.dart';

class EquipmentSelection extends StatelessWidget {
  final String selectedEquipment;
  final Function(String) onEquipmentChanged;
  final Map<String, int> prices;

  const EquipmentSelection({
    Key? key,
    required this.selectedEquipment,
    required this.onEquipmentChanged,
    required this.prices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildEquipmentOption(
            context,
            'PC Gaming',
            'assets/icons/pc_gaming.png',
            'Des PC ultra-performants pour vos sessions de jeu',
            prices['PC Gaming'] ?? 0,
          ),
          const Divider(height: 1, color: AppColors.surfaceColor),
          _buildEquipmentOption(
            context,
            'Xbox Series X',
            'assets/icons/xbox.png',
            'Consoles next-gen avec les derniers jeux',
            prices['Xbox Series X'] ?? 0,
          ),
          const Divider(height: 1, color: AppColors.surfaceColor),
          _buildEquipmentOption(
            context,
            'PS5',
            'assets/icons/ps5.png',
            'Expérience PlayStation 5 avec manettes DualSense',
            prices['PS5'] ?? 0,
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentOption(
    BuildContext context,
    String name,
    String iconPath,
    String description,
    int price,
  ) {
    final bool isSelected = selectedEquipment == name;

    return InkWell(
      onTap: () => onEquipmentChanged(name),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primaryColor.withOpacity(0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Radio button
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected
                          ? AppColors.primaryColor
                          : AppColors.textSecondaryColor,
                  width: 2,
                ),
              ),
              child:
                  isSelected
                      ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                      : null,
            ),
            const SizedBox(width: 16),

            // Icône
            Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? AppColors.primaryColor.withOpacity(0.2)
                        : AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                iconPath,
                width: 32,
                height: 32,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.videogame_asset,
                    color:
                        isSelected
                            ? AppColors.primaryColor
                            : AppColors.textSecondaryColor,
                    size: 32,
                  );
                },
              ),
            ),
            const SizedBox(width: 16),

            // Texte
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color:
                          isSelected
                              ? AppColors.primaryColor
                              : AppColors.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Prix
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$price',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color:
                        isSelected
                            ? AppColors.primaryColor
                            : AppColors.textPrimaryColor,
                  ),
                ),
                const Text(
                  'FCFA/h',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
