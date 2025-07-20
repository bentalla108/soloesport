// lib/presentation/pages/home/home_page.dart
import 'package:flutter/material.dart';

import 'package:soloesport/core/constants/app-theme.dart';
import 'package:soloesport/presentation/widgets/home/event_cart.dart';

import '../../widgets/common/solo_app_bar.dart';
import '../../widgets/common/solo_button.dart';
import '../../widgets/home/feature_card.dart';
import '../../widgets/home/news_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 1.0, curve: Curves.easeInOut),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: SoloAppBar(
        title: 'SOLO ESPORT',
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // En-tête avec animation
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: AppColors.primaryGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Effet visuel futuriste
                        Positioned(
                          right: -50,
                          top: -50,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondaryColor.withOpacity(0.2),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -30,
                          bottom: -60,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accentColor.withOpacity(0.15),
                            ),
                          ),
                        ),
                        // Contenu du header
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'BIENVENUE SUR',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'SOLO ESPORT',
                                style: Theme.of(
                                  context,
                                ).textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SoloButton(
                                label: 'EXPLORER',
                                icon: Icons.arrow_forward,
                                gradient: AppColors.accentGradient,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Section features
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SECTIONS',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Découvrez toutes nos fonctionnalités',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),

              // Grid de features
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.3,
                  ),
                  delegate: SliverChildListDelegate([
                    FeatureCard(
                      title: 'Roster',
                      icon: Icons.people_outline,
                      color: const Color(0xFF6200EA),
                      onTap: () => Navigator.pushNamed(context, '/roster'),
                    ),
                    FeatureCard(
                      title: 'Club',
                      icon: Icons.info_outline,
                      color: const Color(0xFF00B0FF),
                      onTap: () => Navigator.pushNamed(context, '/club-info'),
                    ),
                    FeatureCard(
                      title: 'Réservations',
                      icon: Icons.videogame_asset_outlined,
                      color: const Color(0xFFFFD600),
                      onTap:
                          () => Navigator.pushNamed(context, '/reservations'),
                    ),
                    FeatureCard(
                      title: 'Shop',
                      icon: Icons.shopping_bag_outlined,
                      color: const Color(0xFF00C853),
                      onTap: () => Navigator.pushNamed(context, '/shop'),
                    ),
                    FeatureCard(
                      title: 'Tournois',
                      icon: Icons.emoji_events_outlined,
                      color: const Color(0xFFFF3D00),
                      onTap: () => Navigator.pushNamed(context, '/tournaments'),
                    ),
                    FeatureCard(
                      title: 'Connexion',
                      icon: Icons.login_outlined,
                      color: const Color(0xFF2979FF),
                      onTap: () => Navigator.pushNamed(context, '/login'),
                    ),
                  ]),
                ),
              ),

              // Section actualités
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ACTUALITÉS',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Les dernières nouvelles du club',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),

              // Liste des actualités
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: const [
                      NewsCard(
                        title: 'Notre équipe FIFA est championne nationale',
                        image: 'assets/images/EF.jpg',
                        date: '2 avril 2025',
                        category: 'FIFA',
                      ),
                      NewsCard(
                        title: 'Nouvelle salle gaming au centre de Dakar',
                        image: 'assets/images/news_gaming_room.jpg',
                        date: '31 mars 2025',
                        category: 'Infrastructures',
                      ),
                      NewsCard(
                        title: 'Recrutement: rejoignez notre équipe Valorant',
                        image: 'assets/images/news_valorant.jpg',
                        date: '29 mars 2025',
                        category: 'Valorant',
                      ),
                    ],
                  ),
                ),
              ),

              // Section événements
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ÉVÉNEMENTS À VENIR',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ne manquez pas nos prochains tournois',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),

              // Liste des événements
              SliverList(
                delegate: SliverChildListDelegate([
                  const EventCard(
                    title: 'Tournoi FIFA 25',
                    date: '15 Avril 2025',
                    time: '14:00',
                    location: 'Salle Solo Esport Dakar',
                    gameIcon: 'assets/images/EF.jpg',
                  ),
                  const EventCard(
                    title: 'Championnat PUBG Mobile',
                    date: '22 Avril 2025',
                    time: '16:00',
                    location: 'En ligne',
                    gameIcon: 'assets/images/PUBG.jpg',
                  ),
                  const EventCard(
                    title: 'Coupe Sénégalaise de Mortal Kombat',
                    date: '30 Avril 2025',
                    time: '10:00',
                    location: 'Salle Solo Esport Dakar',
                    gameIcon: 'assets/images/MK.jpg',
                  ),
                  const SizedBox(
                    height: 80,
                  ), // Espace pour le bottom navigation bar
                ]),
              ),
            ],
          ),
        ),
      ),
      // Continuation de lib/presentation/pages/home/home_page.dart (bottomNavigationBar)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.transparent, Color(0xFF121212)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: NavigationBar(
            backgroundColor: AppColors.surfaceColor,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Accueil',
              ),
              NavigationDestination(
                icon: Icon(Icons.people_outlined),
                selectedIcon: Icon(Icons.people),
                label: 'Roster',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_bag_outlined),
                selectedIcon: Icon(Icons.shopping_bag),
                label: 'Shop',
              ),
              NavigationDestination(
                icon: Icon(Icons.emoji_events_outlined),
                selectedIcon: Icon(Icons.emoji_events),
                label: 'Tournois',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outlined),
                selectedIcon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
            selectedIndex: 0,
            onDestinationSelected: (index) {
              switch (index) {
                case 0:
                  // Déjà sur la page d'accueil
                  break;
                case 1:
                  Navigator.pushNamed(context, '/roster');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/shop');
                  break;
                case 3:
                  Navigator.pushNamed(context, '/tournaments');
                  break;
                case 4:
                  Navigator.pushNamed(context, '/login');
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
