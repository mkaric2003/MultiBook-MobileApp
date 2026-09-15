enum StayCollection {
  romanticGetaways('romantic_getaways', 'Romantic getaways'),
  familyFriendly('family_friendly', 'Family friendly'),
  weekendEscapes('weekend_escapes', 'Weekend escapes'),
  beachfrontStays('beachfront_stays', 'Beachfront stays'),
  petFriendly('pet_friendly', 'Pet-friendly stays'),
  poolStays('pool_stays', 'Pool stays'),
  mountainEscapes('mountain_escapes', 'Mountain escapes'),
  cityBreaks('city_breaks', 'City breaks');

  const StayCollection(this.id, this.label);

  final String id;
  final String label;
}
