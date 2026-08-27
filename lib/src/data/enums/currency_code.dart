import 'package:dart_mappable/dart_mappable.dart';

part 'currency_code.mapper.dart';

@MappableEnum()
enum CurrencyCode {
  bam('BAM', 'KM'),
  usd('USD', r'$'),
  eur('EUR', '€'),
  chf('CHF', 'CHF'),
  gbp('GBP', '£');

  const CurrencyCode(this.code, this.symbol);

  final String code;
  final String symbol;
}
