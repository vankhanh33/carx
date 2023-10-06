
class Car {
  final int id;
  final String name;
  final String image;
  final String price;
  const Car({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });
  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        price: json['price_per_day'],
      );

}
