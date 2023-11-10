import 'package:carx/data/model/car_detail.dart';

import 'package:carx/data/model/distributor.dart';
import 'package:equatable/equatable.dart';

enum CarDetailStatus { initial, loading, success, failure }

class CarDetailState extends Equatable {
  final CarDetail? carDetail;
  final Distributor? distributor;
  final CarDetailStatus detailStatus;
  final bool isFavorite;
  const CarDetailState({
    this.carDetail,
    this.distributor,
    required this.detailStatus,
    required this.isFavorite,
  });

  const CarDetailState.initial()
      : carDetail = null,
        distributor = null,
        detailStatus = CarDetailStatus.initial,
        isFavorite = false;

  CarDetailState copyWith({
    CarDetail? carDetail,
    Distributor? distributor,
    CarDetailStatus? detailStatus,
    bool? isFavorite,
  }) =>
      CarDetailState(
        carDetail: carDetail ?? this.carDetail,
        distributor: distributor ?? this.distributor,
        detailStatus: detailStatus ?? this.detailStatus,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  @override
  List<Object?> get props => [
        carDetail,
        distributor,
        detailStatus,
        isFavorite,
      ];
}
