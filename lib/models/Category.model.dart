class Category {
  final String? id;
  final String? name;
  final String? description;
  final String? image;

  Category(
    this.id,
    this.name,
    this.description,
    this.image,
  );

  static Category fromJson(json) => Category(
        json['id'],
        json['name'],
        json['description'],
        json['image'],
      );
}
