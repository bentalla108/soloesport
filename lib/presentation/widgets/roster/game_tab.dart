// lib/presentation/widgets/roster/game_tab.dart
import 'package:flutter/material.dart';
import 'package:soloesport/core/constants/app-theme.dart';

class GameTab extends StatelessWidget {
  final String name;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const GameTab({
    Key? key,
    required this.name,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:
                  isSelected
                      ? AppColors.primaryColor.withOpacity(0.4)
                      : Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
          border: Border.all(
            color:
                isSelected
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône du jeu
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Colors.white.withOpacity(0.2)
                        : AppColors.surfaceColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                iconPath,
                width: 30,
                height: 30,
                color: isSelected ? Colors.white : AppColors.textPrimaryColor,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.videogame_asset,
                    color:
                        isSelected ? Colors.white : AppColors.textPrimaryColor,
                    size: 30,
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
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
