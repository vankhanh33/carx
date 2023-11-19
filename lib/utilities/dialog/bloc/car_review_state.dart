import 'package:equatable/equatable.dart';

enum CarReviewStatus { initial, loading, success, failure }

class CarReviewState extends Equatable {
  final double starRating;
  final String comment;
  final CarReviewStatus status;
  const CarReviewState({
    required this.starRating,
    required this.comment,
    required this.status,
  });
  const CarReviewState.initial()
      : comment = '',
        starRating = 5,
        status = CarReviewStatus.initial;
  CarReviewState copyWith(
          {double? starRating, String? comment, CarReviewStatus? status}) =>
      CarReviewState(
          starRating: starRating ?? this.starRating,
          comment: comment ?? this.comment,
          status: status ?? this.status);

  @override
  List<Object?> get props => [starRating, comment, status];
}
