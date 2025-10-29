// lib/presentation/pages/roster/player_details_page.dart
import 'package:flutter/material.dart';
import '../../../core/constants/app-theme.dart';
import '../../widgets/common/solo_app_bar.dart';
import '../../widgets/common/social_button.dart';
import '../../widgets/roster/stat_card.dart';

class PlayerDetailsPage extends StatelessWidget {
  final dynamic player;

  const PlayerDetailsPage({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const SoloAppBar(title: 'PROFIL DU JOUEUR'),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // En-tête avec photo et informations principales
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1A237E), Color(0xFF0D47A1)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Photo du joueur
                      Hero(
                        tag: 'player-${player['nickname']}',
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.5),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              player['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.surfaceColor,
                                  child: const Icon(
                                    Icons.person,
                                    color: AppColors.textSecondaryColor,
                                    size: 60,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Pseudo
                      Text(
                        player['nickname'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Nom réel
                      Text(
                        player['name'],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Rôle
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          player['role'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Informations de base
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildInfoItem(Icons.cake, '${player['age']} ans'),
                          const SizedBox(width: 24),
                          _buildInfoItem(Icons.flag, player['nationality']),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Réseaux sociaux
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (player['social'] != null &&
                              player['social']['twitter'] != null)
                            SocialButton(
                              icon: Icons.webhook,
                              color: Colors.lightBlue,
                              username: player['social']['twitter'],
                              onTap: () {},
                            ),
                          const SizedBox(width: 16),
                          if (player['social'] != null &&
                              player['social']['instagram'] != null)
                            SocialButton(
                              icon: Icons.camera_alt_outlined,
                              color: Colors.pink,
                              username: player['social']['instagram'],
                              onTap: () {},
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Biographie
                if (player['biography'] != null)
                  _buildSection(
                    context,
                    'BIOGRAPHIE',
                    Icons.description_outlined,
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        player['biography'] ?? 'Aucune biographie disponible.',
                        style: const TextStyle(fontSize: 14, height: 1.6),
                      ),
                    ),
                  ),

                // Statistiques
                if (player['stats'] != null)
                  _buildSection(
                    context,
                    'STATISTIQUES',
                    Icons.bar_chart,
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          for (var entry in player['stats'].entries)
                            StatCard(label: entry.key, value: entry.value),
                        ],
                      ),
                    ),
                  ),

                // Palmarès
                if (player['achievements'] != null)
                  _buildSection(
                    context,
                    'PALMARÈS',
                    Icons.emoji_events_outlined,
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var achievement in player['achievements'] ?? [])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.emoji_events,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      achievement,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if ((player['achievements'] ?? []).isEmpty)
                            const Text(
                              'Pas encore de récompenses majeures.',
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: 16),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    Widget content,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête de section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primaryColor, size: 20),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          // Contenu de la section
          content,
        ],
      ),
    );
  }
}
