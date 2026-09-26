import 'dart:async';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../core/models/payment_result_model.dart';
import '../datasources/payment_remote_datasource.dart';


class RazorpayService {
  final Razorpay _razorpay = Razorpay();

  Razorpay get instance => _razorpay;

  void dispose() {
    _razorpay.clear();
  }

  Future<PaymentResultModel> startPayment({
    required String razorpayOrderId,
    required double amount,
    required String userName,
    required String userEmail,
    required String userPhone,
    required PaymentRemoteDataSource remoteDataSource,
  }) async {
    final completer = Completer<PaymentResultModel>();

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) async {
        try {
          final result =
          await remoteDataSource.verifyPayment(
            orderId: response.orderId ?? '',
            paymentId: response.paymentId ?? '',
            signature: response.signature ?? '',
          );

          completer.complete(result);
        } catch (e) {
          completer.completeError(e);
        }
      },
    );

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
          (PaymentFailureResponse response) {
        completer.completeError(
          Exception(
            response.message ??
                'Payment Failed',
          ),
        );
      },
    );

    _razorpay.on(
      Razorpay.EVENT_EXTERNAL_WALLET,
          (ExternalWalletResponse response) {
        completer.completeError(
          Exception(
            'External Wallet Selected',
          ),
        );
      },
    );

    final options = {
      'key': 'rzp_test_SzzzBbB0N1PAGB',
      'amount': (amount * 100).toInt(),
      'name': 'Trendora',
      'description': 'Order Payment',
      'order_id': razorpayOrderId,
      'prefill': {
        'contact': userPhone,
        'email': userEmail,
        'name': userName,
      },
      'theme': {
        'color': '#E91E63',
      },
    };

    _razorpay.open(options);

    return completer.future;
  }
}







// import 'dart:async';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// import '../utils/payment_event.dart';
//
//
// class RazorpayService {
//   RazorpayService() {
//     _razorpay = Razorpay();
//
//     _razorpay.on(
//       Razorpay.EVENT_PAYMENT_SUCCESS,
//       _handlePaymentSuccess,
//     );
//
//     _razorpay.on(
//       Razorpay.EVENT_PAYMENT_ERROR,
//       _handlePaymentError,
//     );
//
//     _razorpay.on(
//       Razorpay.EVENT_EXTERNAL_WALLET,
//       _handleExternalWallet,
//     );
//   }
//
//   late final Razorpay _razorpay;
//
//   final StreamController<PaymentEvent>
//   _eventController =
//   StreamController<PaymentEvent>.broadcast();
//
//   Stream<PaymentEvent> get paymentStream =>
//       _eventController.stream;
//
//   void openCheckout({
//     required String key,
//     required String orderId,
//     required double amount,
//     required String name,
//     required String description,
//     required String email,
//     required String contact,
//   }) {
//     final options = {
//       'key': key,
//       'amount': (amount * 100).toInt(),
//       'name': name,
//       'description': description,
//       'order_id': orderId,
//       'prefill': {
//         'contact': contact,
//         'email': email,
//       },
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       _eventController.add(
//         PaymentErrorEvent(
//           message: e.toString(),
//         ),
//       );
//     }
//   }
//
//   void _handlePaymentSuccess(
//       PaymentSuccessResponse response,
//       ) {
//     _eventController.add(
//       PaymentSuccessEvent(
//         paymentId:
//         response.paymentId ?? '',
//         orderId:
//         response.orderId ?? '',
//         signature:
//         response.signature ?? '',
//       ),
//     );
//   }
//
//   void _handlePaymentError(
//       PaymentFailureResponse response,
//       ) {
//     _eventController.add(
//       PaymentErrorEvent(
//         code: response.code,
//         message:
//         response.message ??
//             'Payment Failed',
//       ),
//     );
//   }
//
//   void _handleExternalWallet(
//       ExternalWalletResponse response,
//       ) {
//     _eventController.add(
//       ExternalWalletEvent(
//         walletName:
//         response.walletName ?? '',
//       ),
//     );
//   }
//
//   void dispose() {
//     _razorpay.clear();
//     _eventController.close();
//   }
// }