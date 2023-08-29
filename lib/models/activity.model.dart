class Activity {
  final String? id;
  final String? name;
  final String? company;
  final String? description;
  final String? address;
  final String? phone;
  final String? price;
  Map<String, dynamic>? schedule;
  final String? image;
  final String? duration;
  final String? team;
  final String? up_to;
  final String? programme;
  final double latitude;
  final double longitude;
  final String? practical_information;
  final String? city;
  final String? cancellation_conditions;
  final String? categoryId;
  final String? organisatorId;

  Activity(
      this.id,
      this.name,
      this.company,
      this.description,
      this.address,
      this.phone,
      this.price,
      this.schedule,
      this.image,
      this.duration,
      this.team,
      this.up_to,
      this.programme,
      this.latitude,
      this.longitude,
      this.practical_information,
      this.city,
      this.cancellation_conditions,
      this.categoryId,
      this.organisatorId);

  static Activity fromJson(json) => Activity(
        json['id'],
        json['name'],
        json['company'],
        json['description'],
        json['address'],
        json['phone'],
        json['price'],
        json['schedule'],
        json['image'],
        json['duration'],
        json['team'],
        json['up_to'],
        json['programme'],
        json['latitude'],
        json['longitude'],
        json['practical_information'],
        json['city'],
        json['cancellation_conditions'],
        json['category_id'],
        json['organisator_id'],
      );
}
