abstract final class AppointmentDetailsFormatters {
  static String businessCategory(String value) {
    if (value.trim().isEmpty) return 'Service business';
    return value
        .split('_')
        .where((part) => part.isNotEmpty)
        .map(
          (part) =>
              '${part.substring(0, 1).toUpperCase()}${part.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  static String paymentMethod(String value, {required String cashLabel}) {
    if (value.trim().toLowerCase() == 'cash') return cashLabel;
    if (value.trim().isEmpty || value.toLowerCase() == 'card') {
      return 'Card ending in ••••';
    }
    final normalized = value.trim();
    return normalized.startsWith('Card ending in')
        ? normalized
        : 'Card ending in $normalized';
  }
}
