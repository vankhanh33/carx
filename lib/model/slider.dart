class Slider {
  final int id;
  final String image;
  final String car_id;
  const Slider({
    required this.id,
    required this.image,
    required this.car_id,
  });
  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json['id'],
        image: json['image'],
        car_id: json['car_id'],
      );
}
