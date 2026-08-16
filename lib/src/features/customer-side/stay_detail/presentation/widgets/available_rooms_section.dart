import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/domain/models/stay_room.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_room_card.dart';
import 'package:flutter/material.dart';

class AvailableRoomsSection extends StatelessWidget {
  const AvailableRoomsSection({super.key, required this.business});

  final BusinessModel business;

  @override
  Widget build(BuildContext context) {
    final rooms = business.stayDetails?.rooms ?? const [];
    if (rooms.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Available rooms',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 18),
          for (final room in rooms)
            StayRoomCard(
              room: StayRoom(
                name: room.name,
                description:
                    '${room.maxGuests} guests · ${room.sizeSquareMeters}m²',
                pricePerNight: room.pricePerNight,
                imageUrl: business.coverPhotoUrl ?? business.logoUrl ?? '',
              ),
            ),
        ],
      ),
    );
  }
}
