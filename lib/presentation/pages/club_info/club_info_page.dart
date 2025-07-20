// lib/presentation/pages/club_info/club_info_page.dart
import 'package:flutter/material.dart';
import 'package:soloesport/core/constants/app-theme.dart';
import 'package:soloesport/presentation/widgets/club_info/info_section.dart';
import 'package:soloesport/presentation/widgets/club_info/partner_card.dart';
import 'package:soloesport/presentation/widgets/club_info/timeline_item.dart';
import '../../widgets/common/solo_app_bar.dart';

class ClubInfoPage extends StatelessWidget {
  const ClubInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const SoloAppBar(title: 'NOTRE CLUB'),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // En-tête avec image du club
                Stack(
                  children: [
                    // Image
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/club_header.jpg'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Logo et titre
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/solo_logo.png',
                              width: 60,
                              height: 60,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.videogame_asset,
                                  color: AppColors.primaryColor,
                                  size: 40,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SOLO ESPORT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                'Fondé en 2022',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Section À propos
                const InfoSection(
                  title: 'À PROPOS',
                  icon: Icons.info_outline,
                  children: [
                    Text(
                      'Solo Esport est le premier club d\'esport professionnel du Sénégal, fondé en 2022 par un groupe de passionnés de jeux vidéo. Notre mission est de développer l\'écosystème esport sénégalais et africain en formant des joueurs de haut niveau et en organisant des compétitions de standard international.',
                      style: TextStyle(fontSize: 14, height: 1.6),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Avec plusieurs équipes compétitives dans différents jeux populaires (FIFA, Valorant, Call of Duty Mobile, etc.), nous visons à représenter le Sénégal sur la scène internationale et à inspirer la prochaine génération de joueurs professionnels.',
                      style: TextStyle(fontSize: 14, height: 1.6),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Section Vision & Mission
                InfoSection(
                  title: 'VISION & MISSION',
                  icon: Icons.remove_red_eye_outlined,
                  gradientColors: const [Color(0xFF00BCD4), Color(0xFF3F51B5)],
                  children: [
                    _buildVisionMissionItem(
                      'Vision',
                      'Faire du Sénégal une puissance esportive reconnue en Afrique et dans le monde.',
                    ),
                    const SizedBox(height: 12),
                    _buildVisionMissionItem(
                      'Mission',
                      'Former des joueurs professionnels de classe mondiale et créer un écosystème esport durable au Sénégal.',
                    ),
                    const SizedBox(height: 12),
                    _buildVisionMissionItem(
                      'Valeurs',
                      'Excellence, Passion, Innovation, Inclusion, Esprit d\'équipe.',
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Section Histoire
                InfoSection(
                  title: 'NOTRE HISTOIRE',
                  icon: Icons.history,
                  gradientColors: const [Color(0xFFFF9800), Color(0xFFFF5722)],
                  children: [
                    TimelineItem(
                      year: '2022',
                      title: 'Fondation de Solo Esport',
                      description:
                          'Création du club par un groupe de passionnés de jeux vidéo sénégalais.',
                      isFirst: true,
                    ),
                    TimelineItem(
                      year: '2022',
                      title: 'Première équipe FIFA',
                      description:
                          'Formation de notre première équipe compétitive sur FIFA.',
                    ),
                    TimelineItem(
                      year: '2023',
                      title: 'Expansion vers d\'autres jeux',
                      description:
                          'Création des équipes Valorant, Call of Duty Mobile et PUBG.',
                    ),
                    TimelineItem(
                      year: '2023',
                      title: 'Premier championnat national',
                      description:
                          'Victoire au premier championnat national de FIFA organisé à Dakar.',
                    ),
                    TimelineItem(
                      year: '2024',
                      title: 'Ouverture de notre Gaming House',
                      description:
                          'Inauguration de notre salle gaming à Dakar, ouverte au public.',
                    ),
                    TimelineItem(
                      year: '2025',
                      title: 'Développement international',
                      description:
                          'Participation à nos premiers tournois internationaux et partenariats stratégiques.',
                      isLast: true,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Section Structure
                const InfoSection(
                  title: 'STRUCTURE',
                  icon: Icons.account_tree_outlined,
                  gradientColors: [Color(0xFF4CAF50), Color(0xFF009688)],
                  children: [
                    Text(
                      'Solo Esport est organisé en plusieurs départements qui travaillent en synergie pour assurer le succès du club :',
                      style: TextStyle(fontSize: 14, height: 1.6),
                    ),
                    SizedBox(height: 12),

                    // Départements
                    Text(
                      '• Direction & Administration',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '  Gestion stratégique et opérationnelle du club.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),

                    Text(
                      '• Département Sportif',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '  Gestion des équipes, entraînements et compétitions.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),

                    Text(
                      '• Marketing & Communication',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '  Développement de l\'image de marque et relations publiques.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),

                    Text(
                      '• Département Commercial',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '  Partenariats, sponsoring et merchandising.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),

                    Text(
                      '• Innovation & Technologie',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '  Recherche de solutions technologiques pour améliorer les performances.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Section Partenaires
                InfoSection(
                  title: 'NOS PARTENAIRES',
                  icon: Icons.handshake_outlined,
                  gradientColors: const [Color(0xFF9C27B0), Color(0xFFE91E63)],
                  children: [
                    Text(
                      'Solo Esport est fier de collaborer avec les marques et organisations suivantes :',
                      style: TextStyle(fontSize: 14, height: 1.6),
                    ),
                    const SizedBox(height: 16),

                    // Grille de partenaires
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children: const [
                        PartnerCard(
                          name: 'TechSenegal',
                          logo: 'assets/images/partners/partner1.png',
                          type: 'Sponsor Technique',
                        ),
                        PartnerCard(
                          name: 'Gaming World',
                          logo: 'assets/images/partners/partner2.png',
                          type: 'Équipementier',
                        ),
                        PartnerCard(
                          name: 'Sonatel',
                          logo: 'assets/images/partners/partner3.png',
                          type: 'Partenaire Télécom',
                        ),
                        PartnerCard(
                          name: 'Wave Sénégal',
                          logo: 'assets/images/partners/partner4.png',
                          type: 'Sponsor Officiel',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Section Contact
                InfoSection(
                  title: 'NOUS CONTACTER',
                  icon: Icons.contact_mail_outlined,
                  gradientColors: const [Color(0xFF2196F3), Color(0xFF03A9F4)],
                  children: [
                    _buildContactItem(
                      Icons.location_on_outlined,
                      'Adresse',
                      'Rue 12 x Avenue Leopold Sedar Senghor, Dakar',
                    ),
                    const SizedBox(height: 16),
                    _buildContactItem(
                      Icons.email_outlined,
                      'Email',
                      'contact@soloesport.sn',
                    ),
                    const SizedBox(height: 16),
                    _buildContactItem(
                      Icons.phone_outlined,
                      'Téléphone',
                      '+221 78 123 45 67',
                    ),
                    const SizedBox(height: 16),
                    _buildContactItem(
                      Icons.language_outlined,
                      'Site Web',
                      'www.soloesport.sn',
                    ),
                    const SizedBox(height: 20),

                    // Réseaux sociaux
                    const Text(
                      'RÉSEAUX SOCIAUX',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSocialButton(Icons.facebook, Colors.blue),
                        _buildSocialButton(
                          Icons.camera_alt_outlined,
                          Colors.pink,
                        ),
                        _buildSocialButton(Icons.webhook, Colors.lightBlue),
                        _buildSocialButton(Icons.ondemand_video, Colors.red),
                        _buildSocialButton(Icons.discord, Colors.indigo),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisionMissionItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(description, style: const TextStyle(fontSize: 14, height: 1.5)),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.secondaryColor, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}
