import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/payment_method_model.dart';

final paymentProvider = StateProvider<PaymentMethodModel>((ref) => PaymentMethods.cod,);