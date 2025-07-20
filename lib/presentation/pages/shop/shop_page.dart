// lib/presentation/pages/shop/shop_page.dart
import 'package:flutter/material.dart';
import 'package:soloesport/core/constants/app-theme.dart';
import 'package:soloesport/presentation/widgets/common/solo_app_bar.dart';
import 'package:soloesport/presentation/widgets/shop/cart_icon.dart';
import 'package:soloesport/presentation/widgets/shop/product_card.dart';
import 'package:soloesport/presentation/widgets/shop/product_category.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _selectedCategory = 'Tous';
  final List<String> _categories = [
    'Tous',
    'Maillots',
    'Vêtements',
    'Accessoires',
    'Goodies',
    'Éditions limitées',
  ];

  // Données fictives pour les produits (à remplacer par des données réelles)
  final List<Map<String, dynamic>> _products = [
    {
      'id': '1',
      'name': 'Maillot Officiel Solo Esport',
      'category': 'Maillots',
      'price': 25000,
      'description':
          'Maillot officiel de compétition aux couleurs de Solo Esport.',
      'image': 'assets/images/shop/jersey.jpg',
      'rating': 4.8,
      'reviews': 24,
      'isNew': true,
      'isFeatured': true,
      'variations': [
        {
          'name': 'Taille',
          'options': ['S', 'M', 'L', 'XL'],
        },
        {
          'name': 'Équipe',
          'options': ['FIFA', 'Valorant', 'COD', 'Standard'],
        },
      ],
    },
    {
      'id': '2',
      'name': 'T-Shirt Solo Gaming',
      'category': 'Vêtements',
      'price': 12000,
      'description': 'T-shirt casual aux couleurs de Solo Esport.',
      'image': 'assets/images/shop/tshirt.jpg',
      'rating': 4.5,
      'reviews': 18,
      'isNew': false,
      'isFeatured': true,
      'variations': [
        {
          'name': 'Taille',
          'options': ['S', 'M', 'L', 'XL'],
        },
        {
          'name': 'Couleur',
          'options': ['Noir', 'Blanc', 'Bleu'],
        },
      ],
    },
    {
      'id': '3',
      'name': 'Casquette Solo Esport',
      'category': 'Vêtements',
      'price': 8000,
      'description': 'Casquette snapback avec logo Solo Esport brodé.',
      'image': 'assets/images/shop/cap.jpg',
      'rating': 4.2,
      'reviews': 12,
      'isNew': true,
      'isFeatured': false,
      'variations': [
        {
          'name': 'Taille',
          'options': ['Unique'],
        },
        {
          'name': 'Couleur',
          'options': ['Noir', 'Blanc', 'Rouge'],
        },
      ],
    },
    {
      'id': '4',
      'name': 'Tapis de souris Solo Pro',
      'category': 'Accessoires',
      'price': 15000,
      'description':
          'Tapis de souris gaming professionnel aux couleurs de Solo Esport.',
      'image': 'assets/images/shop/mousepad.jpg',
      'rating': 4.9,
      'reviews': 32,
      'isNew': false,
      'isFeatured': true,
      'variations': [
        {
          'name': 'Taille',
          'options': ['Standard', 'XL', 'XXL'],
        },
      ],
    },
    {
      'id': '5',
      'name': 'Mug Solo Esport',
      'category': 'Goodies',
      'price': 6000,
      'description': 'Mug en céramique avec logo Solo Esport.',
      'image': 'assets/images/shop/mug.jpg',
      'rating': 4.3,
      'reviews': 8,
      'isNew': false,
      'isFeatured': false,
      'variations': [
        {
          'name': 'Couleur',
          'options': ['Noir', 'Blanc', 'Bleu'],
        },
      ],
    },
    {
      'id': '6',
      'name': 'Hoodie Édition Champion',
      'category': 'Éditions limitées',
      'price': 30000,
      'description':
          'Hoodie édition spéciale célébrant notre titre de champion.',
      'image': 'assets/images/shop/hoodie.jpg',
      'rating': 5.0,
      'reviews': 15,
      'isNew': true,
      'isFeatured': true,
      'variations': [
        {
          'name': 'Taille',
          'options': ['S', 'M', 'L', 'XL'],
        },
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (_selectedCategory == 'Tous') {
      return _products;
    } else {
      return _products
          .where((product) => product['category'] == _selectedCategory)
          .toList();
    }
  }

  List<Map<String, dynamic>> get featuredProducts {
    return _products.where((product) => product['isFeatured'] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SoloAppBar(
        title: 'SHOP',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Afficher le dialogue de recherche
            },
          ),
          const CartIcon(itemCount: 2), // Remplacer par un compte réel
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
              // Bannière promo
              SliverToBoxAdapter(
                child: Container(
                  height: 150,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/images/shop/promo_banner.jpg'),
                      fit: BoxFit.cover,
                      // En cas d'erreur ou d'image non disponible
                      onError: (_, __) {},
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppColors.primaryColor.withOpacity(0.7),
                          Colors.black.withOpacity(0.7),
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
                            'PROMO SPÉCIALE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '-20% SUR LES MAILLOTS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'VOIR L\'OFFRE',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Catégories horizontales
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return ProductCategory(
                        name: _categories[index],
                        isSelected: _selectedCategory == _categories[index],
                        onTap: () {
                          setState(() {
                            _selectedCategory = _categories[index];
                          });
                        },
                      );
                    },
                  ),
                ),
              ),

              // Titre section produits en vedette
              if (_selectedCategory == 'Tous') ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'PRODUITS EN VEDETTE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Produits en vedette (scrollable horizontalement)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 320,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: featuredProducts.length,
                      itemBuilder: (context, index) {
                        final product = featuredProducts[index];
                        return SizedBox(
                          width: 200,
                          child: ProductCard(
                            id: product['id'],
                            name: product['name'],
                            price: product['price'],
                            image: product['image'],
                            rating: product['rating'],
                            isNew: product['isNew'],
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/product-details',
                                arguments: product,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Titre section tous les produits
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'TOUS LES PRODUITS',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Grille de produits
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      id: product['id'],
                      name: product['name'],
                      price: product['price'],
                      image: product['image'],
                      rating: product['rating'],
                      isNew: product['isNew'],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/product-details',
                          arguments: product,
                        );
                      },
                    );
                  }, childCount: filteredProducts.length),
                ),
              ),

              // Espace en bas
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accentColor,
        onPressed: () {
          // Afficher le panier
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}
