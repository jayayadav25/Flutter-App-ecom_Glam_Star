import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../core/models/payment_order_model.dart';
import '../../../core/models/payment_result_model.dart';

class PaymentRemoteDataSource { PaymentRemoteDataSource();
  final FirebaseFunctions _functions = FirebaseFunctions.instanceFor(
    region: 'us-central1', );

Future<PaymentOrderModel> createOrder({
  required double amount,
  required String receipt,
}) async {
  try {
    // ✅ Force refresh the ID token before calling the function
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not authenticated');
    await user.getIdToken(true); // <-- this is the fix

    print('FUNCTION REGION => us-central1');

    final callable = _functions.httpsCallable('createOrder');

    print('CALLING FUNCTION...');

    final result = await callable.call({
      'amount': amount,
      'receipt': receipt,
    });

    print('FUNCTION RESPONSE => ${result.data}');

    final data = Map<String, dynamic>.from(result.data);
    return PaymentOrderModel.fromMap(data);

  } on FirebaseFunctionsException catch (e) {
    print('FUNCTION ERROR CODE => ${e.code}');
    print('FUNCTION ERROR MESSAGE => ${e.message}');
    print('FUNCTION ERROR DETAILS => ${e.details}');
    rethrow;
  }
}

// Future<PaymentOrderModel> createOrder({
//   required double amount,
//   required String receipt,
// }) async {
//   try {
//     print(
//       'FUNCTION REGION => us-central1',
//     );
//
//     final callable = _functions.httpsCallable(
//       'createOrder',
//     );
//
//     print(
//       'CALLING FUNCTION...',
//     );
//
//     final result = await callable.call({
//       'amount': amount,
//       'receipt': receipt,
//     });
//
//     print(
//       'FUNCTION RESPONSE => ${result.data}',
//     );
//
//     final data = Map<String, dynamic>.from(
//       result.data,
//     );
//
//     return PaymentOrderModel.fromMap(
//       data,
//     );
//   } on FirebaseFunctionsException catch (e) {
//     print(
//       'FUNCTION ERROR CODE => ${e.code}',
//     );
//
//     print(
//       'FUNCTION ERROR MESSAGE => ${e.message}',
//     );
//
//     print(
//       'FUNCTION ERROR DETAILS => ${e.details}',
//     );
//
//     rethrow;
//   }
// }



//   Future<PaymentOrderModel> createOrder({
//   required double amount,
//   required String receipt,
// }) async { try {
//     debugPrint( 'CREATE ORDER REQUEST => amount=$amount receipt=$receipt', );
//
//     final result = await _functions .httpsCallable(
//         'createOrder').call({
//       'amount': amount,
//       'receipt': receipt,
//     });
//     debugPrint( 'CREATE ORDER RESPONSE => ${result.data}', );
//
//     final data = Map<String, dynamic>.from( result.data, );
//     return PaymentOrderModel.fromMap( data, );
//
// }
// on FirebaseFunctionsException catch (e) {
//     debugPrint( 'FUNCTION ERROR CODE => ${e.code}', );
//     debugPrint( 'FUNCTION ERROR MESSAGE => ${e.message}', );
//     debugPrint( 'FUNCTION ERROR DETAILS => ${e.details}', );
//     debugPrint( 'FUNCTION ERROR STACK => ${e.stackTrace}', );
//   rethrow;
// } catch (e, stackTrace) {
//     debugPrint( 'UNKNOWN ERROR => $e', );
//     debugPrint( stackTrace.toString(), );
//   rethrow;
// }
//     }
Future<PaymentResultModel> verifyPayment({
  required String orderId,
  required String paymentId,
  required String signature,
}) async { try {
  final result = await _functions .httpsCallable(
      'verifyPayment'
  ) .call({
    'razorpayOrderId': orderId,
    'razorpayPaymentId': paymentId,
    'razorpaySignature': signature,
  });
  final data = Map<String, dynamic>.from(
    result.data,
  );
  return PaymentResultModel.fromJson( data,);
}
on FirebaseFunctionsException catch (e) {
  debugPrint( 'VERIFY ERROR CODE => ${e.code}', );
  debugPrint( 'VERIFY ERROR MESSAGE => ${e.message}', );
  rethrow; } } Future<void> saveOrder({
  required Map<String, dynamic> orderData,
}) async {
      return;
    }
}






// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:flutter/foundation.dart';
//
// import '../../../core/models/payment_order_model.dart';
// import '../../../core/models/payment_result_model.dart';
//
// class PaymentRemoteDataSource {
// PaymentRemoteDataSource();
//
// final FirebaseFunctions _functions =
// FirebaseFunctions.instanceFor(
// region: 'us-central1',
// );
//
// Future<PaymentOrderModel> createOrder({
// required double amount,
// required String receipt,
// }) async {
// try {
// debugPrint(
// 'CREATE ORDER REQUEST => amount=$amount receipt=$receipt',
// );
//
// final result = await _functions
//     .httpsCallable('createOrder')
//     .call({
// 'amount': amount,
// 'receipt': receipt,
// });
//
// debugPrint(
// 'CREATE ORDER RESPONSE => ${result.data}',
// );
//
// final data =
// Map<String, dynamic>.from(
// result.data,
// );
//
// return PaymentOrderModel.fromMap(
// data,
// );
// } on FirebaseFunctionsException catch (e) {
// debugPrint(
// 'FUNCTION ERROR CODE => ${e.code}',
// );
//
// debugPrint(
// 'FUNCTION ERROR MESSAGE => ${e.message}',
// );
//
// debugPrint(
// 'FUNCTION ERROR DETAILS => ${e.details}',
// );
//
// debugPrint(
// 'FUNCTION ERROR STACK => ${e.stackTrace}',
// );
//
// rethrow;
// } catch (e, stackTrace) {
// debugPrint(
// 'UNKNOWN ERROR => $e',
// );
//
// debugPrint(
// stackTrace.toString(),
// );
//
// rethrow;
// }
// }
//
// Future<PaymentResultModel> verifyPayment({
// required String orderId,
// required String paymentId,
// required String signature,
// }) async {
// try {
// final result = await _functions
//     .httpsCallable('verifyPayment')
//     .call({
// 'razorpayOrderId': orderId,
// 'razorpayPaymentId': paymentId,
// 'razorpaySignature': signature,
// });
//
// final data =
// Map<String, dynamic>.from(
// result.data,
// );
//
// return PaymentResultModel.fromJson(
// data,
// );
// } on FirebaseFunctionsException catch (e) {
// debugPrint(
// 'VERIFY ERROR CODE => ${e.code}',
// );
//
// debugPrint(
// 'VERIFY ERROR MESSAGE => ${e.message}',
// );
//
// rethrow;
// }
// }
//
// Future<void> saveOrder({
// required Map<String, dynamic>
// orderData,
// }) async {
// return;
// }
// }
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:cloud_functions/cloud_functions.dart';
// // import '../../../core/models/payment_order_model.dart';
// // import '../../../core/models/payment_result_model.dart';
// //
// // class PaymentRemoteDataSource { PaymentRemoteDataSource();
// //   final FirebaseFunctions _functions = FirebaseFunctions.instanceFor( region: 'us-central1', );
// //   Future<PaymentOrderModel> createOrder({
// //     required double amount,
// //     required String receipt,
// //   }) async {
// //     try {
// //       final result = await _functions .httpsCallable('createOrder')
// //           .call({
// //         'amount': amount,
// //         'receipt': receipt,
// //       });
// //       final data = Map<String, dynamic>.from( result.data, );
// //       return PaymentOrderModel.fromMap(
// //         data,
// //       );
// //     }
// //     on FirebaseFunctionsException catch (e) {
// //       throw Exception(
// //         e.message ?? 'Failed to create order', );
// //     } }
// // Future<PaymentResultModel> verifyPayment({
// //   required String orderId,
// //   required String paymentId,
// //   required String signature,
// // }) async { try {
// //   final result = await _functions .httpsCallable('verifyPayment')
// //       .call({
// //     'razorpayOrderId': orderId,
// //     'razorpayPaymentId': paymentId,
// //     'razorpaySignature': signature,
// //   });
// //   final data = Map<String, dynamic>.from( result.data, );
// //   return PaymentResultModel.fromJson( data, );
// // } on FirebaseFunctionsException catch (e) {
// //   throw Exception(
// //     e.message ?? 'Payment verification failed', );
// // }
// //   }
// //   Future<void> saveOrder({
// //     required Map<String,
// //         dynamic> orderData,
// //   }) async {
// //     return;
// //   }
// // }