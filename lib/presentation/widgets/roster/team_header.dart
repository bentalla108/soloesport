// lib/presentation/widgets/roster/team_header.dart
import 'package:flutter/material.dart';
import '../../../core/constants/app-theme.dart';

class TeamHeader extends StatelessWidget {
  final String teamName;
  final String description;
  final List<String> achievements;
  final String imagePath;

  const TeamHeader({
    Key? key,
    required this.teamName,
    required this.description,
    required this.achievements,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image d'équipe avec overlay
          SizedBox(
            height: 180,
            width: double.infinity,
            child: Stack(
              children: [
                // Image (à remplacer par une vraie image)
                Positioned.fill(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.primaryColor.withOpacity(0.2),
                        child: const Center(
                          child: Icon(
                            Icons.group,
                            color: AppColors.textSecondaryColor,
                            size: 64,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                // Nom de l'équipe
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    teamName.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Description et palmarès
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textPrimaryColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),

                // Palmarès
                const Text(
                  'PALMARÈS',
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      achievements.map((achievement) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.emoji_events,
                                color: AppColors.accentColor,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  achievement,
                                  style: const TextStyle(
                                    color: AppColors.textPrimaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
