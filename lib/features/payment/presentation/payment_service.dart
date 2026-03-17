import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  final Razorpay _razorpay = Razorpay();

  void openCheckout({
    required int amount,
    required String email,
    required String contact,
    required Function(String transactionId) onSuccess,
    required Function(String message) onError,
  }) {
    var options = {
      'key': 'rzp_test_SSBOXdXkJF75Bq',
      'amount': amount,
      'name': 'Think N Wash',
      'description': 'Service Payment',
      'prefill': {'contact': contact, 'email': email},
    };

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (
      PaymentSuccessResponse response,
    ) {
      final transactionId = response.paymentId ?? "";

      onSuccess(transactionId);
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (
      PaymentFailureResponse response,
    ) {
      onError(response.message ?? "Payment Failed");
    });

    _razorpay.open(options);
  }

  void dispose() {
    _razorpay.clear();
  }
}
