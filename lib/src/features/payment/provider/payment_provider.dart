import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/payment_repository_impl.dart';
import '../datasources/payment_remote_datasource.dart';
import '../service/order_payment_service.dart';
import '../service/razorpay_service.dart';
import 'payment_notifier.dart';
import 'payment_state.dart';

final paymentRemoteDataSourceProvider =
Provider<PaymentRemoteDataSource>(
      (ref) => PaymentRemoteDataSource(),
);

final razorpayServiceProvider =
Provider<RazorpayService>(
      (ref) {
    final service = RazorpayService();

    ref.onDispose(() {
      service.dispose();
    });

    return service;
  },
);

final paymentRepositoryProvider =
Provider<PaymentRepositoryImpl>(
      (ref) {
    return PaymentRepositoryImpl(
      remoteDataSource:
      ref.read(
        paymentRemoteDataSourceProvider,
      ),
      razorpayService:
      ref.read(
        razorpayServiceProvider,
      ),
    );
  },
);

final paymentProvider =
StateNotifierProvider<
    PaymentNotifier,
    PaymentState>(
      (ref) {
    return PaymentNotifier(
      ref.read(
        paymentRepositoryProvider,
      ),
    );
  },
);

final orderPaymentServiceProvider =
Provider<OrderPaymentService>(
      (ref) => OrderPaymentService(),
);

