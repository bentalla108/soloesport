// lib/presentation/pages/shop/product_details_page.dart
import 'package:flutter/material.dart';
import 'package:soloesport/core/constants/app-theme.dart';
import '../../widgets/common/solo_app_bar.dart';
import '../../widgets/common/solo_button.dart';
import '../../widgets/shop/product_image_carousel.dart';
import '../../widgets/shop/variation_selector.dart';

class ProductDetailsPage extends StatefulWidget {
  final dynamic product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _quantity = 1;
  Map<String, String> _selectedVariations = {};

  @override
  void initState() {
    super.initState();
    // Initialiser les variations sélectionnées avec la première option
    if (widget.product['variations'] != null) {
      for (var variation in widget.product['variations']) {
        if (variation['options'] != null && variation['options'].isNotEmpty) {
          _selectedVariations[variation['name']] = variation['options'][0];
        }
      }
    }
  }

  void _incrementQuantity() {
    setState(() {
      if (_quantity < 10) {
        _quantity++;
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void _updateVariation(String name, String value) {
    setState(() {
      _selectedVariations[name] = value;
    });
  }

  void _addToCart() {
    // Afficher un message de confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.product['name']} ajouté au panier'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'VOIR PANIER',
          textColor: Colors.white,
          onPressed: () {
            // Naviguer vers le panier
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SoloAppBar(
        title: 'PRODUIT',
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Ajouter aux favoris
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Partager le produit
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
          child: Column(
            children: [
              // Contenu scrollable
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Carousel d'images
                      ProductImageCarousel(
                        isNew: true,
                        mainImage: widget.product['image'],
                        additionalImages:
                            widget.product['additionalImages'] ?? [],
                      ),

                      // Informations du produit
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nom et prix
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.product['name'],
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimaryColor,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${widget.product['price']} FCFA',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.accentColor,
                                      ),
                                    ),
                                    if (widget.product['oldPrice'] != null)
                                      Text(
                                        '${widget.product['oldPrice']} FCFA',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textSecondaryColor,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Note et avis
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.product['rating']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '(${widget.product['reviews']} avis)',
                                  style: const TextStyle(
                                    color: AppColors.textSecondaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Description
                            const Text(
                              'DESCRIPTION',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.product['description'],
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Variations
                            if (widget.product['variations'] != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'OPTIONS',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  for (var variation
                                      in widget.product['variations'])
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                      ),
                                      child: VariationSelector(
                                        name: variation['name'],
                                        options: List<String>.from(
                                          variation['options'],
                                        ),
                                        selectedOption:
                                            _selectedVariations[variation['name']] ??
                                            variation['options'][0],
                                        onSelected:
                                            (value) => _updateVariation(
                                              variation['name'],
                                              value,
                                            ),
                                      ),
                                    ),
                                ],
                              ),

                            // Quantité
                            const SizedBox(height: 8),
                            const Text(
                              'QUANTITÉ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                InkWell(
                                  onTap: _decrementQuantity,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.remove, size: 20),
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
                                    color: AppColors.surfaceColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    _quantity.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: _incrementQuantity,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.add, size: 20),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Informations supplémentaires
                            const Text(
                              'INFORMATIONS SUPPLÉMENTAIRES',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  _buildInfoRow(
                                    'Catégorie',
                                    widget.product['category'],
                                  ),
                                  const Divider(
                                    height: 24,
                                    color: AppColors.cardColor,
                                  ),
                                  _buildInfoRow(
                                    'Délai de livraison',
                                    '3-5 jours ouvrables',
                                  ),
                                  const Divider(
                                    height: 24,
                                    color: AppColors.cardColor,
                                  ),
                                  _buildInfoRow('Retours', 'Sous 14 jours'),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Produits recommandés (placeholder)
                            const Text(
                              'VOUS POURRIEZ AUSSI AIMER',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 200,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  _buildRecommendedProduct(
                                    'Casquette Solo Esport',
                                    8000,
                                    'assets/images/shop/cap.jpg',
                                  ),
                                  _buildRecommendedProduct(
                                    'T-Shirt Solo Gaming',
                                    12000,
                                    'assets/images/shop/tshirt.jpg',
                                  ),
                                  _buildRecommendedProduct(
                                    'Hoodie Édition Champion',
                                    30000,
                                    'assets/images/shop/hoodie.jpg',
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 80,
                            ), // Espace pour le bouton fixe en bas
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bouton d'ajout au panier fixe en bas
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'PRIX TOTAL',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondaryColor,
                            ),
                          ),
                          Text(
                            '${widget.product['price'] * _quantity} FCFA',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SoloButton(
                        label: 'AJOUTER AU PANIER',
                        icon: Icons.shopping_cart,
                        onPressed: _addToCart,
                        gradient: const [Color(0xFF00C853), Color(0xFF00E676)],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondaryColor,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildRecommendedProduct(String name, int price, String image) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              image,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  color: AppColors.surfaceColor,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: AppColors.textSecondaryColor,
                  ),
                );
              },
            ),
          ),

          // Nom et prix
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '$price FCFA',
                  style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
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
