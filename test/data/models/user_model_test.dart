import 'package:flutter_test/flutter_test.dart';
import 'package:multibook/src/data/enums/currency_code.dart';
import 'package:multibook/src/data/enums/user_type.dart';
import 'package:multibook/src/data/models/user_model.dart';

void main() {
  test('maps the users API response through UserModel', () {
    final user = UserModel.fromMap({
      'id': 'firebase-uid',
      'email': 'user@example.com',
      'full_name': 'Mirza Karic',
      'first_name': 'Mirza',
      'last_name': 'Karic',
      'role': 'customer',
      'phone_e164': '+38761123456',
      'avatar_storage_path': 'profiles/firebase-uid/profile.webp',
      'country_code': 'BA',
      'date_of_birth': '2000-01-02T00:00:00.000Z',
      'address': 'Example 1',
      'city': 'Sarajevo',
      'business_currency': 'BAM',
    });

    expect(user.fullName, 'Mirza Karic');
    expect(user.type, UserType.customer);
    expect(user.phoneNumber, '+38761123456');
    expect(
      user.profileImageUrl,
      'profiles/firebase-uid/profile.webp',
    );
    expect(user.businessCurrency, CurrencyCode.bam);
    expect(user.toMap()['business_currency'], 'BAM');
  });
}
