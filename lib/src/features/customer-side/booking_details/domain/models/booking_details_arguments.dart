import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/data/models/stay_room_model.dart';

class BookingDetailsArguments {
  const BookingDetailsArguments({
    required this.stay,
    this.pricePerNight,
    this.room,
  });

  final StayListing stay;
  final int? pricePerNight;
  final StayRoomModel? room;
}
