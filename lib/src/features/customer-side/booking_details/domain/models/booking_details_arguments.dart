import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';

class BookingDetailsArguments {
  const BookingDetailsArguments({required this.stay, this.pricePerNight});

  final StayListing stay;
  final int? pricePerNight;
}
