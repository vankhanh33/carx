import 'package:carx/data/model/car_detail.dart';
import 'package:carx/data/model/distributor_model.dart';

class Detail {
  final DistributorModel distributorModel;
  final CarDetail carDetail;
  const Detail({required this.distributorModel, required this.carDetail});
  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        distributorModel: DistributorModel.fromJson(json['distributor']),
        carDetail: CarDetail.fromJson(json['car']),
      );
}
