class BusinessReviewModel {
  const BusinessReviewModel({
    required this.id,
    required this.customerName,
    required this.rating,
    this.customerAvatarUrl,
    this.comment,
  });

  factory BusinessReviewModel.fromJson(Map<String, dynamic> json) =>
      BusinessReviewModel(
        id: json['id'] as String? ?? '',
        customerName: json['customerName'] as String? ?? '',
        customerAvatarUrl: json['customerAvatarUrl'] as String?,
        rating: (json['rating'] as num?)?.toInt() ?? 0,
        comment: json['comment'] as String?,
      );

  final String id;
  final String customerName;
  final String? customerAvatarUrl;
  final int rating;
  final String? comment;
}
