import 'package:dart_mappable/dart_mappable.dart';

part 'currency_code.mapper.dart';

@MappableEnum()
enum CurrencyCode {
  @MappableValue('BAM')
  bam('BAM', 'KM'),
  @MappableValue('USD')
  usd('USD', r'$'),
  @MappableValue('EUR')
  eur('EUR', '€'),
  @MappableValue('CHF')
  chf('CHF', 'CHF'),
  @MappableValue('GBP')
  gbp('GBP', '£');

  const CurrencyCode(this.code, this.symbol);

  final String code;
  final String symbol;
}
