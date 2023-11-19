abstract class CarReviewEvent {}

class CommentInputCarReviewEvent extends CarReviewEvent {
  final String comment;
  CommentInputCarReviewEvent(this.comment);
}

class StarRatingVoteEvent extends CarReviewEvent {
  final double starRating;
  StarRatingVoteEvent(this.starRating);
}

class SubmitCarReviewEvent extends CarReviewEvent {
  final int carId;
  SubmitCarReviewEvent(this.carId);
}
