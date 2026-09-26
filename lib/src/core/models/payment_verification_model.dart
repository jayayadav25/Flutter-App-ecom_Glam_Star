
import '../../features/payment/widgets/payment_verification.dart';

class PaymentVerificationModel
    extends PaymentVerification {
  const PaymentVerificationModel({
    required super.paymentId,
    required super.orderId,
    required super.verified,
  });

  factory PaymentVerificationModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return PaymentVerificationModel(
      paymentId: json['paymentId'] ?? '',
      orderId: json['orderId'] ?? '',
      verified: json['verified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'orderId': orderId,
      'verified': verified,
    };
  }

  factory PaymentVerificationModel.fromEntity(
      PaymentVerification entity,
      ) {
    return PaymentVerificationModel(
      paymentId: entity.paymentId,
      orderId: entity.orderId,
      verified: entity.verified,
    );
  }
}