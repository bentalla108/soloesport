// lib/presentation/pages/tournaments/tournaments_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app-theme.dart';
import 'tournament_card.dart';
import '../../widgets/common/solo_app_bar.dart';
import '../../widgets/tournaments/tab_selector.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({Key? key}) : super(key: key);

  @override
  _TournamentsPageState createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['À venir', 'En cours', 'Passés'];

  // Données fictives pour les tournois
  final List<Map<String, dynamic>> _upcomingTournaments = [
    {
      'id': 't1',
      'name': 'Coupe Solo Esport FIFA 25',
      'game': 'FIFA 25',
      'gameIcon': 'assets/icons/fifa.png',
      'startDate': DateTime(2025, 4, 15, 14, 0),
      'endDate': DateTime(2025, 4, 15, 20, 0),
      'location': 'Salle Solo Esport Dakar',
      'isOnline': false,
      'registrationFee': 5000,
      'prizePool': 250000,
      'status': 'open',
      'maxParticipants': 32,
      'currentParticipants': 18,
      'description':
          'Tournoi FIFA 25 ouvert à tous les joueurs. Venez montrer vos talents et gagnez des prix exceptionnels!',
      'format': 'Élimination directe',
      'rules': [
        'Matchs en 1vs1',
        'Mode: Match amical en ligne',
        'Durée des mi-temps: 6 minutes',
        'Difficulté: Légende',
        'Équipes: Tous clubs et nations autorisés',
      ],
      'prizes': [
        {'position': '1er', 'reward': '150 000 FCFA + Trophée'},
        {'position': '2ème', 'reward': '75 000 FCFA'},
        {'position': '3ème', 'reward': '25 000 FCFA'},
      ],
      'image': 'assets/images/tournaments/fifa_tournament.jpg',
    },
    {
      'id': 't2',
      'name': 'Championnat Call of Duty Mobile',
      'game': 'Call of Duty Mobile',
      'gameIcon': 'assets/icons/cod.png',
      'startDate': DateTime(2025, 4, 22, 16, 0),
      'endDate': DateTime(2025, 4, 23, 20, 0),
      'location': 'En ligne',
      'isOnline': true,
      'registrationFee': 10000,
      'prizePool': 500000,
      'status': 'open',
      'maxParticipants': 16,
      'currentParticipants': 8,
      'description':
          'Championnat d\'élite pour les équipes COD Mobile. Affrontez les meilleures équipes du pays!',
      'format': 'Phase de groupes + Playoffs',
      'rules': [
        'Équipes de 5 joueurs',
        'Mode: Recherche et Destruction',
        'Maps: Firing Range, Nuketown, Standoff, Summit',
        'Interdiction des Scorestreaks',
        'Double élimination en playoffs',
      ],
      'prizes': [
        {'position': '1er', 'reward': '300 000 FCFA + Qualification régionale'},
        {'position': '2ème', 'reward': '150 000 FCFA'},
        {'position': '3ème-4ème', 'reward': '25 000 FCFA'},
      ],
      'image': 'assets/images/tournaments/cod_tournament.jpg',
    },
    {
      'id': 't3',
      'name': 'Coupe Sénégalaise de Mortal Kombat',
      'game': 'Mortal Kombat',
      'gameIcon': 'assets/icons/mk.png',
      'startDate': DateTime(2025, 4, 30, 10, 0),
      'endDate': DateTime(2025, 4, 30, 18, 0),
      'location': 'Salle Solo Esport Dakar',
      'isOnline': false,
      'registrationFee': 3000,
      'prizePool': 150000,
      'status': 'open',
      'maxParticipants': 64,
      'currentParticipants': 41,
      'description':
          'Le plus grand tournoi de jeux de combat au Sénégal. Prouvez que vous êtes le meilleur combattant!',
      'format': 'Élimination directe (BO3)',
      'rules': [
        'Matchs en 1vs1',
        'Sélection de personnage libre',
        'Best of 3 en phases préliminaires',
        'Best of 5 en finale',
        'Apportez votre propre manette/stick arcade (optionnel)',
      ],
      'prizes': [
        {'position': '1er', 'reward': '100 000 FCFA + Figurine collector'},
        {'position': '2ème', 'reward': '50 000 FCFA'},
        {'position': '3ème', 'reward': '25 000 FCFA'},
        {'position': '4ème', 'reward': '10 000 FCFA'},
      ],
      'image': 'assets/images/tournaments/mk_tournament.jpg',
    },
  ];

  final List<Map<String, dynamic>> _ongoingTournaments = [
    {
      'id': 't4',
      'name': 'Ligue Valorant Dakar',
      'game': 'Valorant',
      'gameIcon': 'assets/icons/valorant.png',
      'startDate': DateTime(2025, 4, 1, 18, 0),
      'endDate': DateTime(2025, 5, 15, 22, 0),
      'location': 'Salle Solo Esport Dakar & En ligne',
      'isOnline': true,
      'registrationFee': 15000,
      'prizePool': 1000000,
      'status': 'ongoing',
      'maxParticipants': 12,
      'currentParticipants': 12,
      'description':
          'Championnat majeur Valorant s\'étendant sur plusieurs semaines. Les meilleures équipes s\'affrontent pour la gloire!',
      'format': 'Ligue + Playoffs',
      'rules': [
        'Équipes de 5 joueurs + 1 remplaçant',
        'Phase de ligue: matchs aller-retour',
        'Playoffs: Top 6 équipes, bracket à élimination simple',
        'Règles officielles Valorant Esports',
      ],
      'prizes': [
        {
          'position': '1er',
          'reward': '500 000 FCFA + Qualification pour EMEA Challengers',
        },
        {'position': '2ème', 'reward': '300 000 FCFA'},
        {'position': '3ème', 'reward': '150 000 FCFA'},
        {'position': '4ème', 'reward': '50 000 FCFA'},
      ],
      'image': 'assets/images/tournaments/valorant_tournament.jpg',
      'currentStage': 'Phase de groupes - Semaine 3/6',
      'liveStreamUrl': 'https://www.twitch.tv/soloesport',
    },
  ];

  final List<Map<String, dynamic>> _pastTournaments = [
    {
      'id': 't5',
      'name': 'PUBG Mobile Invitational',
      'game': 'PUBG Mobile',
      'gameIcon': 'assets/icons/pubg.png',
      'startDate': DateTime(2025, 3, 15, 12, 0),
      'endDate': DateTime(2025, 3, 15, 20, 0),
      'location': 'Salle Solo Esport Dakar',
      'isOnline': false,
      'registrationFee': 8000,
      'prizePool': 300000,
      'status': 'completed',
      'maxParticipants': 16,
      'currentParticipants': 16,
      'description':
          'Tournoi PUBG Mobile en squads. 16 équipes, 5 matchs, un seul vainqueur!',
      'results': [
        {'position': '1er', 'team': 'Team Savage', 'reward': '180 000 FCFA'},
        {'position': '2ème', 'team': 'DKR Killers', 'reward': '90 000 FCFA'},
        {
          'position': '3ème',
          'team': 'Solo Alpha Squad',
          'reward': '30 000 FCFA',
        },
      ],
      'image': 'assets/images/tournaments/pubg_tournament.jpg',
      'highlightsUrl': 'https://www.youtube.com/soloesport',
    },
    {
      'id': 't6',
      'name': 'Tournoi PES 2024',
      'game': 'PES',
      'gameIcon': 'assets/icons/pes.png',
      'startDate': DateTime(2025, 2, 28, 14, 0),
      'endDate': DateTime(2025, 2, 28, 20, 0),
      'location': 'Salle Solo Esport Dakar',
      'isOnline': false,
      'registrationFee': 5000,
      'prizePool': 200000,
      'status': 'completed',
      'maxParticipants': 32,
      'currentParticipants': 32,
      'description':
          'Tournoi Pro Evolution Soccer. La stratégie rencontre l\'habileté!',
      'results': [
        {'position': '1er', 'team': 'MbayeFoot', 'reward': '120 000 FCFA'},
        {'position': '2ème', 'team': 'KingSoccer', 'reward': '60 000 FCFA'},
        {'position': '3ème', 'team': 'DiougoupeFC', 'reward': '20 000 FCFA'},
      ],
      'image': 'assets/images/tournaments/pes_tournament.jpg',
      'highlightsUrl': 'https://www.youtube.com/soloesport',
    },
  ];

  // Fonction pour obtenir la liste actuelle en fonction de l'onglet sélectionné
  List<Map<String, dynamic>> get _currentTournaments {
    switch (_selectedTabIndex) {
      case 0:
        return _upcomingTournaments;
      case 1:
        return _ongoingTournaments;
      case 2:
        return _pastTournaments;
      default:
        return _upcomingTournaments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const SoloAppBar(title: 'TOURNOIS'),
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
              // Bannière
              Container(
                margin: const EdgeInsets.all(16),
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/tournaments/banner.jpg'),
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
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.purple.withOpacity(0.8),
                        Colors.blue.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'AFFRONTEZ LES MEILLEURS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Participez à nos tournois et démontrez votre talent',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'INSCRIVEZ-VOUS',
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Sélecteur d'onglets
              TabSelector(
                tabs: _tabs,
                selectedIndex: _selectedTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),

              // Liste de tournois
              Expanded(
                child:
                    _currentTournaments.isEmpty
                        ? const Center(
                          child: Text(
                            'Aucun tournoi dans cette catégorie',
                            style: TextStyle(
                              color: AppColors.textSecondaryColor,
                            ),
                          ),
                        )
                        : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _currentTournaments.length,
                          itemBuilder: (context, index) {
                            final tournament = _currentTournaments[index];
                            return TournamentCard(
                              name: tournament['name'],
                              game: tournament['game'],
                              gameIcon: tournament['gameIcon'],
                              date: DateFormat(
                                'dd MMM yyyy • HH:mm',
                              ).format(tournament['startDate']),
                              location: tournament['location'],
                              isOnline: tournament['isOnline'],
                              status: tournament['status'],
                              prizePool: tournament['prizePool'],
                              image: tournament['image'],
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/tournament-details',
                                  arguments: tournament,
                                );
                              },
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accentColor,
        onPressed: () {
          // Afficher un dialogue d'information sur la création de tournoi
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  backgroundColor: AppColors.cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: const Text('Organiser un tournoi'),
                  content: const Text(
                    'Vous souhaitez organiser votre propre tournoi avec Solo Esport? Contactez-nous pour discuter des modalités et obtenir notre aide dans l\'organisation.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'FERMER',
                        style: TextStyle(color: AppColors.secondaryColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Rediriger vers la page de contact ou formulaire
                      },
                      child: const Text(
                        'CONTACTER',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
