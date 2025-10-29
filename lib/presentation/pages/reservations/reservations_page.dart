// lib/presentation/pages/reservations/reservations_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app-theme.dart';
import '../../widgets/reservations/equipment_selection.dart';
import '../../widgets/reservations/time_slot_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../widgets/common/solo_app_bar.dart';
import '../../widgets/common/solo_button.dart';

class ReservationsPage extends StatefulWidget {
  const ReservationsPage({Key? key}) : super(key: key);

  @override
  _ReservationsPageState createState() => _ReservationsPageState();
}

class _ReservationsPageState extends State<ReservationsPage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<String, int> _equipmentPrices = {
    'PC Gaming': 2000, // Prix en FCFA
    'Xbox Series X': 1500,
    'PS5': 1500,
  };

  String _selectedEquipment = 'PC Gaming';
  int _quantity = 1;
  int _hours = 1;
  int _guests = 0;

  DateTime? _selectedTimeSlot;
  final List<DateTime> _availableTimeSlots = [
    DateTime(2025, 4, 9, 10, 0),
    DateTime(2025, 4, 9, 12, 0),
    DateTime(2025, 4, 9, 14, 0),
    DateTime(2025, 4, 9, 16, 0),
    DateTime(2025, 4, 9, 18, 0),
    DateTime(2025, 4, 9, 20, 0),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  int _calculateTotal() {
    int basePrice = _equipmentPrices[_selectedEquipment] ?? 0;
    int total = basePrice * _quantity * _hours;
    // Ajouter frais pour invités (par exemple 500 FCFA par invité)
    total += _guests * 500;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const SoloAppBar(title: 'RÉSERVATION'),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section titre avec animation
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3F51B5), Color(0xFF2196F3)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3F51B5).withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.videogame_asset,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Réservez votre session de gaming',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Sélectionnez la date, l\'heure et l\'équipement',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Section calendrier
                  _buildSectionTitle(context, 'Date de réservation'),
                  const SizedBox(height: 8),
                  Container(
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
                    child: TableCalendar(
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 60)),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          _selectedTimeSlot =
                              null; // Réinitialiser le créneau horaire
                        });
                      },
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        todayDecoration: BoxDecoration(
                          color: AppColors.secondaryColor.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        markerDecoration: const BoxDecoration(
                          color: AppColors.accentColor,
                          shape: BoxShape.circle,
                        ),
                        weekendTextStyle: const TextStyle(
                          color: AppColors.textSecondaryColor,
                        ),
                        defaultTextStyle: const TextStyle(
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                          color: AppColors.textPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        leftChevronIcon: const Icon(
                          Icons.chevron_left,
                          color: AppColors.textPrimaryColor,
                        ),
                        rightChevronIcon: const Icon(
                          Icons.chevron_right,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Section créneau horaire
                  _buildSectionTitle(context, 'Créneau horaire'),
                  const SizedBox(height: 8),
                  TimeSlotPicker(
                    availableTimeSlots: _availableTimeSlots,
                    selectedTimeSlot: _selectedTimeSlot,
                    onTimeSlotSelected: (timeSlot) {
                      setState(() {
                        _selectedTimeSlot = timeSlot;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  // Section équipement
                  _buildSectionTitle(context, 'Choix de l\'équipement'),
                  const SizedBox(height: 8),
                  EquipmentSelection(
                    selectedEquipment: _selectedEquipment,
                    onEquipmentChanged: (equipment) {
                      setState(() {
                        _selectedEquipment = equipment;
                      });
                    },
                    prices: _equipmentPrices,
                  ),
                  const SizedBox(height: 24),

                  // Section quantité et durée
                  _buildSectionTitle(context, 'Détails de la réservation'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
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
                      children: [
                        // Nombre de postes/consoles
                        _buildCounterField(
                          context,
                          'Nombre de ${_selectedEquipment == 'PC Gaming' ? 'postes' : 'consoles'}',
                          _quantity,
                          (value) {
                            setState(() {
                              _quantity = value;
                            });
                          },
                          minValue: 1,
                          maxValue: 10,
                        ),
                        const SizedBox(height: 16),

                        // Nombre d'heures
                        _buildCounterField(
                          context,
                          'Nombre d\'heures',
                          _hours,
                          (value) {
                            setState(() {
                              _hours = value;
                            });
                          },
                          minValue: 1,
                          maxValue: 8,
                        ),
                        const SizedBox(height: 16),

                        // Nombre d'invités
                        _buildCounterField(
                          context,
                          'Nombre d\'invités',
                          _guests,
                          (value) {
                            setState(() {
                              _guests = value;
                            });
                          },
                          minValue: 0,
                          maxValue: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Section récapitulatif
                  _buildSectionTitle(context, 'Récapitulatif'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildRecapRow(
                          'Date',
                          _selectedDay != null
                              ? DateFormat('dd MMMM yyyy').format(_selectedDay!)
                              : 'Non sélectionnée',
                        ),
                        const SizedBox(height: 12),
                        _buildRecapRow(
                          'Heure',
                          _selectedTimeSlot != null
                              ? DateFormat('HH:mm').format(_selectedTimeSlot!)
                              : 'Non sélectionnée',
                        ),
                        const SizedBox(height: 12),
                        _buildRecapRow(
                          'Équipement',
                          '$_selectedEquipment x $_quantity',
                        ),
                        const SizedBox(height: 12),
                        _buildRecapRow(
                          'Durée',
                          '$_hours heure${_hours > 1 ? 's' : ''}',
                        ),
                        const SizedBox(height: 12),
                        _buildRecapRow(
                          'Invités',
                          '$_guests personne${_guests > 1 ? 's' : ''}',
                        ),
                        const Divider(
                          color: AppColors.textSecondaryColor,
                          height: 32,
                        ),
                        _buildRecapRow(
                          'Prix total',
                          '${_calculateTotal().toString()} FCFA',
                          isTotal: true,
                        ),
                        const SizedBox(height: 8),
                        _buildRecapRow(
                          'Acompte à payer (20%)',
                          '${(_calculateTotal() * 0.2).round().toString()} FCFA',
                          textColor: AppColors.accentColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Bouton de réservation
                  SoloButton(
                    label: 'CONFIRMER ET PAYER',
                    icon: Icons.check_circle_outline,
                    gradient: const [Color(0xFF00C853), Color(0xFF00E676)],
                    height: 54,
                    onPressed: () {
                      if (_selectedDay == null || _selectedTimeSlot == null) {
                        // Afficher un message d'erreur
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Veuillez sélectionner une date et un créneau horaire',
                            ),
                            backgroundColor: AppColors.errorColor,
                          ),
                        );
                        return;
                      }

                      // Procéder au paiement
                      _showPaymentModal(context);
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
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
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildCounterField(
    BuildContext context,
    String label,
    int value,
    Function(int) onChanged, {
    required int minValue,
    required int maxValue,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimaryColor,
            fontSize: 16,
          ),
        ),
        Row(
          children: [
            _buildCounterButton(
              Icons.remove,
              () {
                if (value > minValue) {
                  onChanged(value - 1);
                }
              },
              isDecrement: true,
              isDisabled: value <= minValue,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value.toString(),
                style: const TextStyle(
                  color: AppColors.textPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildCounterButton(
              Icons.add,
              () {
                if (value < maxValue) {
                  onChanged(value + 1);
                }
              },
              isDecrement: false,
              isDisabled: value >= maxValue,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCounterButton(
    IconData icon,
    VoidCallback onPressed, {
    required bool isDecrement,
    required bool isDisabled,
  }) {
    return InkWell(
      onTap:
          isDisabled
              ? null
              : () {
                onPressed();
                HapticFeedback.lightImpact();
              },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              isDisabled
                  ? AppColors.textDisabledColor.withOpacity(0.2)
                  : (isDecrement
                      ? AppColors.errorColor.withOpacity(0.2)
                      : AppColors.successColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color:
              isDisabled
                  ? AppColors.textDisabledColor
                  : (isDecrement
                      ? AppColors.errorColor
                      : AppColors.successColor),
          size: 20,
        ),
      ),
    );
  }

  Widget _buildRecapRow(
    String label,
    String value, {
    bool isTotal = false,
    Color? textColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondaryColor,
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color:
                textColor ??
                (isTotal ? AppColors.accentColor : AppColors.textPrimaryColor),
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showPaymentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Barre de drag en haut
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 16),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Titre
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  'MÉTHODE DE PAIEMENT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),

              const Divider(color: AppColors.textSecondaryColor, height: 1),

              // Méthodes de paiement
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    // Montant à payer
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'ACOMPTE À PAYER (20%)',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${(_calculateTotal() * 0.2).round().toString()} FCFA',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Le reste sera à payer sur place',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Liste des méthodes de paiement
                    const Text(
                      'CHOISISSEZ VOTRE MÉTHODE',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Wave
                    _buildPaymentMethodCard(
                      'Wave',
                      'assets/icons/wave.png',
                      const Color(0xFF1DCCDF),
                      onTap: () {
                        // Logique de paiement Wave
                        Navigator.pop(context);
                        _showPaymentConfirmation(context);
                      },
                    ),
                    const SizedBox(height: 12),

                    // Orange Money
                    _buildPaymentMethodCard(
                      'Orange Money',
                      'assets/icons/orange_money.png',
                      const Color(0xFFFF6B00),
                      onTap: () {
                        // Logique de paiement Orange Money
                        Navigator.pop(context);
                        _showPaymentConfirmation(context);
                      },
                    ),
                    const SizedBox(height: 12),

                    // Carte bancaire
                    _buildPaymentMethodCard(
                      'Carte Bancaire',
                      'assets/icons/credit_card.png',
                      const Color(0xFF5B6BBF),
                      onTap: () {
                        // Logique de paiement par carte
                        Navigator.pop(context);
                        _showPaymentConfirmation(context);
                      },
                    ),
                  ],
                ),
              ),

              // Bouton d'annulation
              Padding(
                padding: const EdgeInsets.all(24),
                child: SoloButton(
                  label: 'ANNULER',
                  isOutlined: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentMethodCard(
    String name,
    String iconPath,
    Color color, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                iconPath,
                width: 30,
                height: 30,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.payment, color: color, size: 30);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }

  void _showPaymentConfirmation(BuildContext context) {
    // Simuler un processus de paiement avec un délai
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Traitement du paiement en cours...',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );

    // Simuler un délai et afficher la confirmation
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Fermer le dialogue de chargement

      // Afficher la confirmation
      Navigator.pushNamed(
        context,
        '/reservation-confirmation',
        arguments: {
          'date': _selectedDay,
          'timeSlot': _selectedTimeSlot,
          'equipment': _selectedEquipment,
          'quantity': _quantity,
          'hours': _hours,
          'guests': _guests,
          'total': _calculateTotal(),
          'deposit': (_calculateTotal() * 0.2).round(),
        },
      );
    });
  }
}
