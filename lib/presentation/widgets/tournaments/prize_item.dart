// lib/presentation/widgets/tournaments/prize_item.dart
import 'package:flutter/material.dart';
import '../../../core/constants/app-theme.dart';

class PrizeItem extends StatelessWidget {
  final String position;
  final String reward;
  final String? teamName;

  const PrizeItem({
    Key? key,
    required this.position,
    required this.reward,
    this.teamName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color positionColor;
    IconData? medalIcon;

    // Déterminer la couleur et l'icône selon la position
    if (position == '1er') {
      positionColor = Colors.amber;
      medalIcon = Icons.emoji_events;
    } else if (position == '2ème') {
      positionColor = Colors.grey.shade300;
      medalIcon = Icons.emoji_events;
    } else if (position == '3ème') {
      positionColor = Colors.brown.shade300;
      medalIcon = Icons.emoji_events;
    } else {
      positionColor = AppColors.textSecondaryColor;
      medalIcon = null;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Badge de position
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: positionColor.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: positionColor, width: 2),
            ),
            child: Center(
              child:
                  medalIcon != null
                      ? Icon(medalIcon, color: positionColor, size: 24)
                      : Text(
                        position,
                        style: TextStyle(
                          color: positionColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
            ),
          ),
          const SizedBox(width: 16),

          // Informations
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      position,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    Text(
                      reward,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.accentColor,
                      ),
                    ),
                  ],
                ),
                if (teamName != null)
                  Text(
                    'Équipe: $teamName',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
