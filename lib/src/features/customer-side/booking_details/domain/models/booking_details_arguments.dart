import 'package:multibook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:multibook/src/data/models/stay_room_model.dart';
import 'package:multibook/src/data/models/booking_draft_model.dart';

class BookingDetailsArguments {
  const BookingDetailsArguments({
    required this.stay,
    this.pricePerNight,
    this.room,
    this.draft,
  });

  final StayListing stay;
  final int? pricePerNight;
  final StayRoomModel? room;
  final BookingDraftModel? draft;
}
