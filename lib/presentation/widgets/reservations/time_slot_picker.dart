// lib/presentation/widgets/reservations/time_slot_picker.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app-theme.dart';

class TimeSlotPicker extends StatelessWidget {
  final List<DateTime> availableTimeSlots;
  final DateTime? selectedTimeSlot;
  final Function(DateTime) onTimeSlotSelected;

  const TimeSlotPicker({
    Key? key,
    required this.availableTimeSlots,
    required this.selectedTimeSlot,
    required this.onTimeSlotSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: availableTimeSlots.length,
        itemBuilder: (context, index) {
          final timeSlot = availableTimeSlots[index];
          final isSelected =
              selectedTimeSlot != null &&
              selectedTimeSlot!.hour == timeSlot.hour &&
              selectedTimeSlot!.minute == timeSlot.minute;

          return GestureDetector(
            onTap: () => onTimeSlotSelected(timeSlot),
            child: Container(
              width: 80,
              margin: EdgeInsets.only(
                right: index < availableTimeSlots.length - 1 ? 12 : 0,
              ),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.primaryColor : AppColors.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:
                      isSelected
                          ? AppColors.primaryColor
                          : AppColors.primaryColor.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow:
                    isSelected
                        ? [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ]
                        : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('HH:mm').format(timeSlot),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color:
                          isSelected
                              ? Colors.white
                              : AppColors.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Disponible',
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          isSelected
                              ? Colors.white.withOpacity(0.8)
                              : AppColors.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
