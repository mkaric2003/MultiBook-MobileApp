import 'package:aquabook/src/data/models/stay_extra_model.dart';
import 'package:aquabook/src/features/customer-side/review_stay/domain/models/review_stay_arguments.dart';

class PaymentArguments {
  const PaymentArguments({required this.review, required this.selectedExtras});
  final ReviewStayArguments review;
  final List<StayExtraModel> selectedExtras;
}
