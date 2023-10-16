class Brand {
  final int? id;
  final String name;
  final String image;

  const Brand({
     this.id,
    required this.name,
    required this.image,
  });
  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: int.parse(json['id']),
        name: json['name'],
        image: json['image'],
      );
}
