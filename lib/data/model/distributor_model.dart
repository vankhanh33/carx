class DistributorModel {
  final int id;

  final String uId;

  final String image;

  final String name;

  final String email;

  final String address;

  final String phone;

  final String descriptions;

  final double latitude;

  final double longtitude;

  const DistributorModel({
    required this.id,
    required this.uId,
    required this.image,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.descriptions,
    required this.latitude,
    required this.longtitude,
  });

  factory DistributorModel.fromJson(Map<String, dynamic> json) =>
      DistributorModel(
        id: int.parse(json['id']),
        uId: json['user_id'],
        image: json['image'],
        name: json['name'],
        email: json['email'],
        address: json['address'],
        phone: json['phone'],
        descriptions: json['descriptions'],
        latitude: double.parse(json['latitude']),
        longtitude: double.parse(json['longtitude']),
      );
}

