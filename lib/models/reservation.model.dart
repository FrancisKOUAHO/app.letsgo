class Reservation {
  final String? id;
  final String? user_id;
  final bool? used_qrcode;
  final String? status;
  final String? payment_status;
  final String? number_of_places;
  final String? time_of_session;
  final String? date_of_session;
  final String? total_price;
  final String? qrcode;
  final bool? is_confirmed;
  Map<String, dynamic>? users;
  Map<String, dynamic>? activities;

  Reservation(
    this.id,
    this.user_id,
    this.used_qrcode,
    this.status,
    this.payment_status,
    this.number_of_places,
    this.time_of_session,
    this.date_of_session,
    this.total_price,
    this.qrcode,
    this.is_confirmed,
    this.users,
    this.activities,
  );

  static Reservation fromJson(json) => Reservation(
        json['id'],
        json['user_id'],
        json['used_qrcode'],
        json['status'],
        json['payment_status'],
        json['number_of_places'],
        json['time_of_session'],
        json['date_of_session'],
        json['total_price'],
        json['qrcode'],
        json['is_confirmed'],
        json['users'],
        json['activities'],
      );
}
