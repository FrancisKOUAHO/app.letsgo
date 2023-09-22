class Reservation {
  final String? id;
  final String? userId;
  final String? activityId;
  final bool? usedQrcode;
  final String? status;
  final String? qrcode;
  final bool? isConfirmed;
  final String? paymentStatus;
  final String? paymentMethod;
  final String? numberOfPlaces;
  final String? timeOfSession;
  final String? dateOfSession;
  final String? totalPrice;
  final String? inviteName;
  final String? fullName;
  final String? email;
  final String? phone;
  final Map<String, dynamic>? activities;

  Reservation({
    this.id,
    this.userId,
    this.activityId,
    this.usedQrcode,
    this.status,
    this.qrcode,
    this.isConfirmed,
    this.paymentStatus,
    this.paymentMethod,
    this.numberOfPlaces,
    this.timeOfSession,
    this.dateOfSession,
    this.totalPrice,
    this.inviteName,
    this.fullName,
    this.email,
    this.phone,
    this.activities,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      userId: json['user_id'],
      activityId: json['activity_id'],
      usedQrcode: json['used_qrcode'] as bool?,
      status: json['status'],
      qrcode: json['qrcode'],
      isConfirmed: json['is_confirmed'] as bool?,
      paymentStatus: json['payment_status'],
      paymentMethod: json['payment_method'],
      numberOfPlaces: json['number_of_places'],
      timeOfSession: json['time_of_session'],
      dateOfSession: json['date_of_session'],
      totalPrice: json['total_price'],
      inviteName: json['invite_name'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      activities: json['activities'],
    );
  }
}