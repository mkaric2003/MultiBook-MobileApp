class CustomerEditProfileFormData {
  const CustomerEditProfileFormData({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.countryCode,
    required this.dateOfBirth,
    required this.address,
  });

  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String countryCode;
  final DateTime? dateOfBirth;
  final String address;
}
