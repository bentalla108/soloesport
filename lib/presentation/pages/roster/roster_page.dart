// lib/presentation/pages/roster/roster_page.dart
import 'package:flutter/material.dart';
import '../../../core/constants/app-theme.dart';
import '../../widgets/common/solo_app_bar.dart';
import '../../widgets/roster/game_tab.dart';
import '../../widgets/roster/player_card.dart';
import '../../widgets/roster/team_header.dart';

class RosterPage extends StatefulWidget {
  const RosterPage({Key? key}) : super(key: key);

  @override
  _RosterPageState createState() => _RosterPageState();
}

class _RosterPageState extends State<RosterPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _games = [
    'FIFA',
    'Mortal Kombat',
    'PES',
    'PUBG',
    'Call of Duty',
    'Valorant',
  ];

  final Map<String, String> _gameIcons = {
    'FIFA': 'assets/icons/fifa.png',
    'Mortal Kombat': 'assets/icons/mk.png',
    'PES': 'assets/icons/pes.png',
    'PUBG': 'assets/icons/pubg.png',
    'Call of Duty': 'assets/icons/cod.png',
    'Valorant': 'assets/icons/valorant.png',
  };

  // Données fictives pour les équipes (à remplacer par des données réelles)
  final Map<String, Map<String, dynamic>> _teamData = {
    'FIFA': {
      'name': 'Dream Team FIFA',
      'description':
          'Notre équipe FIFA est composée de joueurs élites spécialisés dans les compétitions eFootball.',
      'achievements': [
        'Champion National 2024',
        'Vice-champion d\'Afrique 2023',
      ],
      'image': 'assets/images/team_fifa.jpg',
      'players': [
        {
          'name': 'Matar Diop',
          'nickname': 'MatarGoal',
          'age': 23,
          'nationality': 'Sénégalais',
          'role': 'Capitaine',
          'image': 'assets/images/players/matar.jpg',
          'stats': {
            'Victoires': '87%',
            'Buts/Match': '3.2',
            'Compétitions': '28',
          },
          'social': {'twitter': '@matargoal', 'instagram': 'matargoal'},
        },
        {
          'name': 'Amadou Sow',
          'nickname': 'AmaSkilz',
          'age': 21,
          'nationality': 'Sénégalais',
          'role': 'Attaquant',
          'image': 'assets/images/players/amadou.jpg',
          'stats': {
            'Victoires': '82%',
            'Buts/Match': '2.7',
            'Compétitions': '15',
          },
          'social': {'twitter': '@amaskilz', 'instagram': 'amaskilz'},
        },
        {
          'name': 'Fatou Ndiaye',
          'nickname': 'FatouTactic',
          'age': 22,
          'nationality': 'Sénégalaise',
          'role': 'Milieu',
          'image': 'assets/images/players/fatou.jpg',
          'stats': {
            'Victoires': '75%',
            'Passes/Match': '4.1',
            'Compétitions': '20',
          },
          'social': {'twitter': '@fatoutactic', 'instagram': 'fatoutactic'},
        },
      ],
    },
    'Valorant': {
      'name': 'Solo Valiant',
      'description':
          'Notre équipe Valorant est reconnue pour sa stratégie et sa précision.',
      'achievements': ['Top 3 Tournoi Africain 2023', 'Vainqueur WAEC 2024'],
      'image': 'assets/images/team_valorant.jpg',
      'players': [
        {
          'name': 'Abdoulaye Faye',
          'nickname': 'AbdouAim',
          'age': 24,
          'nationality': 'Sénégalais',
          'role': 'Duelist',
          'image': 'assets/images/players/abdou.jpg',
          'stats': {'K/D Ratio': '1.8', 'HS%': '68%', 'Tournois': '12'},
          'social': {'twitter': '@abdouaim', 'instagram': 'abdouaim'},
        },
        {
          'name': 'Moussa Diallo',
          'nickname': 'MoussaVision',
          'age': 20,
          'nationality': 'Sénégalais',
          'role': 'Sentinel',
          'image': 'assets/images/players/moussa.jpg',
          'stats': {'K/D Ratio': '1.5', 'HS%': '62%', 'Tournois': '10'},
          'social': {'twitter': '@moussavision', 'instagram': 'moussavision'},
        },
        {
          'name': 'Aisha Ba',
          'nickname': 'AishaSmoke',
          'age': 22,
          'nationality': 'Sénégalaise',
          'role': 'Controller',
          'image': 'assets/images/players/aisha.jpg',
          'stats': {'K/D Ratio': '1.6', 'HS%': '58%', 'Tournois': '14'},
          'social': {'twitter': '@aishasmoke', 'instagram': 'aishasmoke'},
        },
        {
          'name': 'Omar Seck',
          'nickname': 'OmarTactical',
          'age': 23,
          'nationality': 'Sénégalais',
          'role': 'Initiator',
          'image': 'assets/images/players/omar.jpg',
          'stats': {'K/D Ratio': '1.4', 'HS%': '55%', 'Tournois': '8'},
          'social': {'twitter': '@omartactical', 'instagram': 'omartactical'},
        },
        {
          'name': 'Sophie Mendy',
          'nickname': 'SophieShot',
          'age': 21,
          'nationality': 'Sénégalaise',
          'role': 'Duelist',
          'image': 'assets/images/players/sophie.jpg',
          'stats': {'K/D Ratio': '1.7', 'HS%': '71%', 'Tournois': '9'},
          'social': {'twitter': '@sophieshot', 'instagram': 'sophieshot'},
        },
      ],
    },
    'Call of Duty': {
      'name': 'Solo Force',
      'description':
          'L\'élite de Call of Duty Mobile, connue pour sa domination dans les tournois ouest-africains.',
      'achievements': [
        'Champion WAEC 2023',
        'Finaliste Tournoi Pan-africain 2024',
      ],
      'image': 'assets/images/team_cod.jpg',
      'players': [
        // Données des joueurs COD...
      ],
    },
    'Mortal Kombat': {
      'name': 'Solo Fighters',
      'description':
          'Des combattants d\'élite représentant le Sénégal dans les tournois Mortal Kombat.',
      'achievements': [
        'Top 8 Continental Championship 2023',
        'Champion National 2024',
      ],
      'image': 'assets/images/team_mk.jpg',
      'players': [
        // Données des joueurs Mortal Kombat...
      ],
    },
    'PES': {
      'name': 'Solo Pro Evolution',
      'description':
          'L\'équipe PES de Solo Esport, des tactitiens hors pair spécialisés dans le football virtuel.',
      'achievements': ['Demi-finaliste Coupe d\'Afrique eFootball 2023'],
      'image': 'assets/images/team_pes.jpg',
      'players': [
        // Données des joueurs PES...
      ],
    },
    'PUBG': {
      'name': 'Solo Survivors',
      'description':
          'Une équipe tactique qui domine dans les Battle Royale du PUBG mobile.',
      'achievements': [
        'Top 5 PUBG Mobile Africa 2023',
        'Vainqueur Tournoi National 2024',
      ],
      'image': 'assets/images/team_pubg.jpg',
      'players': [
        // Données des joueurs PUBG...
      ],
    },
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _games.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const SoloAppBar(title: 'ROSTER'),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Tabs pour les jeux
              Container(
                height: 110,
                margin: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _games.length,
                  itemBuilder: (context, index) {
                    return GameTab(
                      name: _games[index],
                      iconPath: _gameIcons[_games[index]] ?? '',
                      isSelected: _tabController.index == index,
                      onTap: () {
                        setState(() {
                          _tabController.animateTo(index);
                        });
                      },
                    );
                  },
                ),
              ),

              // Contenu des tabs
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const BouncingScrollPhysics(),
                  children:
                      _games.map((game) {
                        final teamInfo = _teamData[game];
                        if (teamInfo == null) {
                          return const Center(
                            child: Text('Données de l\'équipe non disponibles'),
                          );
                        }

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // En-tête de l'équipe
                              TeamHeader(
                                teamName: teamInfo['name'],
                                description: teamInfo['description'],
                                achievements: List<String>.from(
                                  teamInfo['achievements'] ?? [],
                                ),
                                imagePath: teamInfo['image'],
                              ),

                              // Divider futuriste
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: AppColors.secondaryColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.5),
                                          width: 1,
                                        ),
                                      ),
                                      child: const Text(
                                        'JOUEURS',
                                        style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: AppColors.secondaryColor
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Liste des joueurs
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      (teamInfo['players'] as List?)?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    final player =
                                        (teamInfo['players'] as List)[index];
                                    return PlayerCard(
                                      name: player['name'],
                                      nickname: player['nickname'],
                                      role: player['role'],
                                      imagePath: player['image'],
                                      age: player['age'],
                                      nationality: player['nationality'],
                                      stats: Map<String, String>.from(
                                        player['stats'] ?? {},
                                      ),
                                      socialLinks: Map<String, String>.from(
                                        player['social'] ?? {},
                                      ),
                                      onTap: () {
                                        // Navigation vers la page détaillée du joueur
                                        Navigator.pushNamed(
                                          context,
                                          '/player-details',
                                          arguments: player,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 32),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
