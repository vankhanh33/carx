// ignore_for_file: unnecessary_this

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? address;
  final String? gender;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.address,
    this.gender,
  });
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        image: json['image'],
        address: json['address'],
        phone: json['phone'],
        gender: json['gender'],
      );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataUser =  Map<String, dynamic>();
    dataUser['id'] = this.id ?? '';
    dataUser['name'] = this.name ?? '';
    dataUser['email'] = this.email ?? '';
    dataUser['image'] = this.image ?? 'N/A';
    dataUser['address'] = this.address ?? '';
    dataUser['phone'] = this.phone ?? '';
    dataUser['gender'] = this.gender ?? '';
    return dataUser;
  }
}
