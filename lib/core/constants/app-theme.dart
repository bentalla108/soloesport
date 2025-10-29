// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales
  static const Color primaryColor = Color(0xFFF89F00); // Violet profond
  // static const Color primaryColor = Color(0xFF6200EA); // Violet profond
  static const Color secondaryColor = Color(0xFF00E5FF); // Cyan électrique
  static const Color accentColor = Color(0xFFFFD600); // Jaune énergique

  // Couleurs de fond
  static const Color backgroundColor = Color(0xFF121212); // Presque noir
  static const Color surfaceColor = Color(0xFF1E1E1E); // Gris très foncé
  static const Color cardColor = Color(0xFF2D2D2D); // Gris foncé

  // Couleurs de texte
  static const Color textPrimaryColor = Color(0xFFFFFFFF); // Blanc
  static const Color textSecondaryColor = Color(0xFFB0B0B0); // Gris clair
  static const Color textDisabledColor = Color(0xFF757575); // Gris moyen

  // Couleurs d'état
  static const Color successColor = Color(0xFF00C853); // Vert
  static const Color warningColor = Color(0xFFFFAB00); // Orange
  static const Color errorColor = Color(0xFFFF1744); // Rouge

  // Dégradés
  static const List<Color> primaryGradient = [
    Color(0xFF6200EA),
    Color(0xFF7C4DFF),
  ];

  static const List<Color> accentGradient = [
    Color(0xFF00E5FF),
    Color(0xFF2979FF),
  ];

  static const List<Color> backgroundGradient = [
    Color(0xFF121212),
    Color(0xFF1F1F1F),
  ];
}
