import 'package:multibook/src/core/theme/app_colors.dart';
import 'package:multibook/l10n/l10n.dart';
import 'package:multibook/src/features/customer-side/stay_detail/domain/models/stay_room.dart';
import 'package:flutter/material.dart';

class StayRoomCard extends StatelessWidget {
  const StayRoomCard({super.key, required this.room, required this.onBook});

  final StayRoom room;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            room.imageUrl,
            height: 145,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  room.description,
                  style: const TextStyle(color: AppColors.muted, fontSize: 15),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${context.l10n.formatCurrency(room.pricePerNight)} ${context.l10n.perNight}',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: onBook,
                      child: Text(context.l10n.book),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
