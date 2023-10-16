class Car {
  final int id;
  final String name;
  final String image;
  final String price;
  final String brand;
  const Car(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.brand});
  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: int.parse(json['id']),
        name: json['name'],
        image: json['image'],
        price: json['price_per_day'],
        brand: json['brand_name'],
      );
}
