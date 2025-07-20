// lib/presentation/pages/reservations/reservation_confirmation_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:soloesport/core/constants/app-theme.dart';
import '../../widgets/common/solo_app_bar.dart';
import '../../widgets/common/solo_button.dart';

class ReservationConfirmationPage extends StatelessWidget {
  final dynamic reservation;

  const ReservationConfirmationPage({Key? key, required this.reservation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Générer un ID de réservation fictif
    final String reservationId =
        'RSV-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';

    return Scaffold(
      appBar: const SoloAppBar(title: 'CONFIRMATION'),
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Badge de succès
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 24),

                // Titre
                const Text(
                  'Réservation confirmée',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Sous-titre
                const Text(
                  'Votre réservation a été enregistrée avec succès',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Carte de réservation
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // En-tête avec QR Code
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: AppColors.primaryGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'SOLO ESPORT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'ID de réservation: $reservationId',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // QR Code
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: QrImageView(
                                data: reservationId,
                                version: QrVersions.auto,
                                size: 150,
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 12),

                            const Text(
                              'Présentez ce code à l\'accueil',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Détails de la réservation
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _buildReservationDetail(
                              'Date',
                              DateFormat(
                                'dd MMMM yyyy',
                              ).format(reservation['date']),
                              Icons.calendar_today,
                            ),
                            const SizedBox(height: 16),

                            _buildReservationDetail(
                              'Heure',
                              DateFormat(
                                'HH:mm',
                              ).format(reservation['timeSlot']),
                              Icons.access_time,
                            ),
                            const SizedBox(height: 16),

                            _buildReservationDetail(
                              'Équipement',
                              '${reservation['equipment']} x ${reservation['quantity']}',
                              Icons.videogame_asset,
                            ),
                            const SizedBox(height: 16),

                            _buildReservationDetail(
                              'Durée',
                              '${reservation['hours']} heure${reservation['hours'] > 1 ? 's' : ''}',
                              Icons.hourglass_bottom,
                            ),
                            const SizedBox(height: 16),

                            _buildReservationDetail(
                              'Invités',
                              '${reservation['guests']} personne${reservation['guests'] > 1 ? 's' : ''}',
                              Icons.people,
                            ),
                            const SizedBox(height: 24),

                            // Récapitulatif prix
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.accentColor.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  _buildPriceRow(
                                    'Prix total',
                                    '${reservation['total']} FCFA',
                                  ),
                                  const SizedBox(height: 12),
                                  _buildPriceRow(
                                    'Acompte payé (20%)',
                                    '${reservation['deposit']} FCFA',
                                    isAccent: true,
                                  ),
                                  const SizedBox(height: 12),
                                  _buildPriceRow(
                                    'Reste à payer',
                                    '${reservation['total'] - reservation['deposit']} FCFA',
                                    isTotal: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Informations supplémentaires
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: Colors.blue.shade600,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Informations importantes',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '• Veuillez vous présenter 15 minutes avant votre créneau\n'
                        '• Le reste du paiement sera à effectuer sur place\n'
                        '• En cas d\'annulation, contactez-nous au moins 24h à l\'avance\n'
                        '• Une pièce d\'identité pourra vous être demandée',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Boutons d'action
                Row(
                  children: [
                    Expanded(
                      child: SoloButton(
                        label: 'PARTAGER',
                        icon: Icons.share,
                        isOutlined: true,
                        onPressed: () {
                          // Logique de partage
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SoloButton(
                        label: 'AJOUTER AU CALENDRIER',
                        icon: Icons.calendar_today,
                        onPressed: () {
                          // Logique d'ajout au calendrier
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                SoloButton(
                  label: 'RETOUR À L\'ACCUEIL',
                  icon: Icons.home,
                  onPressed: () {
                    // Retour à l'accueil
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  },
                  gradient: const [Color(0xFF00C853), Color(0xFF00E676)],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReservationDetail(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primaryColor, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(
    String label,
    String value, {
    bool isTotal = false,
    bool isAccent = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color:
                isTotal
                    ? AppColors.textPrimaryColor
                    : AppColors.textSecondaryColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: FontWeight.bold,
            color:
                isAccent
                    ? AppColors.accentColor
                    : (isTotal
                        ? AppColors.primaryColor
                        : AppColors.textPrimaryColor),
          ),
        ),
      ],
    );
  }
}
