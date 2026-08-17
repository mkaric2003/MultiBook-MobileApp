class BookingDetailsState {
  const BookingDetailsState({
    required this.checkIn,
    required this.checkOut,
    required this.visibleMonth,
    this.adults = 2,
    this.children = 0,
    this.infants = 0,
    this.isSelectingCheckIn = true,
  });

  factory BookingDetailsState.initial() {
    final today = DateTime.now();
    final checkIn = DateTime(
      today.year,
      today.month,
      today.day,
    ).add(const Duration(days: 1));
    return BookingDetailsState(
      checkIn: checkIn,
      checkOut: checkIn.add(const Duration(days: 2)),
      visibleMonth: DateTime(checkIn.year, checkIn.month),
    );
  }

  final DateTime checkIn;
  final DateTime checkOut;
  final DateTime visibleMonth;
  final int adults;
  final int children;
  final int infants;
  final bool isSelectingCheckIn;

  int get totalGuests => adults + children + infants;
  int get nightCount => checkOut.difference(checkIn).inDays;

  BookingDetailsState copyWith({
    DateTime? checkIn,
    DateTime? checkOut,
    DateTime? visibleMonth,
    int? adults,
    int? children,
    int? infants,
    bool? isSelectingCheckIn,
  }) => BookingDetailsState(
    checkIn: checkIn ?? this.checkIn,
    checkOut: checkOut ?? this.checkOut,
    visibleMonth: visibleMonth ?? this.visibleMonth,
    adults: adults ?? this.adults,
    children: children ?? this.children,
    infants: infants ?? this.infants,
    isSelectingCheckIn: isSelectingCheckIn ?? this.isSelectingCheckIn,
  );
}
