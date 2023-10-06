class Brand {
  final int id;
  final String name;
  final String image;

  const Brand({
    required this.id,
    required this.name,
    required this.image,
  });
  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json['id'],
        name: json['name'],
        image: json['image'],
      );
}
