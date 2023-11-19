// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class CarReview extends Equatable {
  String id;
  double rating;
  String comment;
  String createdAs;
  int like;
  int dislike;
  String userId;
  String userName;
  CarReview({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAs,
    required this.like,
    required this.dislike,
    required this.userId,
    required this.userName,
  });

  factory CarReview.fromJson(Map<String, dynamic> json) => CarReview(
        id: json['id'],
        rating: double.parse(json['rating']),
        comment: json['comment'] ?? '',
        createdAs: json['created_as'],
        like: int.parse(json['like']),
        dislike: int.parse(json['dislike']),
        userId: json['user_id'],
        userName: json['user_name'] ?? 'anonymous',
      );

  @override
  List<Object?> get props =>
      [id, rating, comment, createdAs, like, dislike, userId, userName];
}
