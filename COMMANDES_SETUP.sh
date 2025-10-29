#!/bin/bash

# 🚀 SCRIPT D'INSTALLATION - SOLO ESPORT APP
# Ce script configure votre projet Flutter avec Firebase

echo "======================================"
echo "📱 SOLO ESPORT - Setup Automatique"
echo "======================================"
echo ""

# Vérifier Flutter
echo "1️⃣ Vérification de Flutter..."
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter n'est pas installé"
    echo "Installez Flutter: https://docs.flutter.dev/get-started/install"
    exit 1
fi
echo "✅ Flutter trouvé: $(flutter --version | head -n 1)"
echo ""

# Installer FlutterFire CLI
echo "2️⃣ Installation de FlutterFire CLI..."
dart pub global activate flutterfire_cli
echo "✅ FlutterFire CLI installé"
echo ""

# Installer les dépendances
echo "3️⃣ Installation des dépendances..."
flutter pub get
echo "✅ Dépendances installées"
echo ""

# Configurer Firebase
echo "4️⃣ Configuration Firebase..."
echo "⚠️  Suivez les instructions pour sélectionner votre projet Firebase"
echo ""
flutterfire configure
echo "✅ Firebase configuré"
echo ""

# Créer la structure de dossiers
echo "5️⃣ Création de la structure de dossiers..."
mkdir -p lib/core/constants lib/core/network lib/core/errors lib/core/usecases
mkdir -p lib/data/datasources/firebase lib/data/datasources/local lib/data/models lib/data/repositories
mkdir -p lib/domain/entities lib/domain/repositories lib/domain/usecases/auth lib/domain/usecases/tournaments lib/domain/usecases/shop lib/domain/usecases/reservations lib/domain/usecases/roster
mkdir -p lib/presentation/blocs/auth lib/presentation/blocs/tournaments lib/presentation/blocs/shop lib/presentation/blocs/reservations lib/presentation/blocs/roster
mkdir -p lib/presentation/pages/splash lib/presentation/pages/home lib/presentation/pages/auth lib/presentation/pages/tournaments lib/presentation/pages/shop lib/presentation/pages/reservations lib/presentation/pages/roster lib/presentation/pages/club_info lib/presentation/pages/profile
mkdir -p lib/presentation/widgets/common lib/presentation/widgets/home lib/presentation/widgets/tournaments lib/presentation/widgets/shop lib/presentation/widgets/reservations lib/presentation/widgets/roster
mkdir -p assets/images/players assets/images/shop assets/images/tournaments assets/images/partners assets/icons assets/fonts/exo assets/fonts/orbitron
echo "✅ Structure créée"
echo ""

echo "======================================"
echo "✅ Setup terminé !"
echo "======================================"
echo ""
echo "📋 PROCHAINES ÉTAPES:"
echo ""
echo "1. Récupérez les 5 DataSources Firebase depuis:"
echo "   https://claude.ai/chat/1df6f81c-3bf1-44ac-b748-5fa312299a62"
echo ""
echo "2. Placez-les dans: lib/data/datasources/firebase/"
echo ""
echo "3. Créez les fichiers suivants (voir LISTE_FICHIERS.md):"
echo "   - lib/routes.dart"
echo "   - lib/injection_container.dart"
echo "   - Les BLoCs"
echo "   - Les pages"
echo "   - Les models"
echo ""
echo "4. Lancez l'app:"
echo "   flutter run"
echo ""
echo "📚 Documentation:"
echo "   - README.md - Documentation complète"
echo "   - GUIDE_RAPIDE.md - Guide rapide"
echo "   - RECAPITULATIF_COMPLET.md - Vue d'ensemble"
echo ""
echo "🚀 Bon développement !"
