import 'package:aquabook/app.dart';
import 'package:aquabook/l10n/l10n.dart';
import 'package:aquabook/src/data/models/business_model.dart';
import 'package:aquabook/src/features/customer-side/booking_details/domain/models/booking_details_arguments.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/domain/models/stay_room.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_room_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AvailableRoomsSection extends StatelessWidget {
  const AvailableRoomsSection({
    super.key,
    required this.business,
    required this.stay,
  });

  final BusinessModel business;
  final StayListing stay;

  @override
  Widget build(BuildContext context) {
    final rooms = (business.stayDetails?.rooms ?? const [])
        .where((room) => room.isActive)
        .toList();
    if (rooms.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.availableRooms,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 18),
          for (final room in rooms)
            StayRoomCard(
              room: StayRoom(
                name: room.name,
                description: context.l10n.roomGuestsAndSize(
                  room.maxGuests,
                  room.sizeSquareMeters,
                ),
                pricePerNight: room.pricePerNight,
                imageUrl: business.coverPhotoUrl ?? business.logoUrl ?? '',
              ),
              onBook: () => context.push(
                AppRoutes.BOOKING_DETAILS,
                extra: BookingDetailsArguments(
                  stay: stay,
                  pricePerNight: room.pricePerNight,
                  room: room,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
