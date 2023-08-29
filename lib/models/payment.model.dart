class PaymentModel {
  final String? user_id;
  final String? TokenIdStripe;
  final String? reservation_id;
  final int? amount;

  PaymentModel(
      this.user_id, this.TokenIdStripe, this.reservation_id, this.amount);
}
