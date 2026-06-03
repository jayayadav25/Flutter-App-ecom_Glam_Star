import '../../../core/models/user_request_model.dart';
import '../datasources/checkout_datasource.dart';
import '../datasources/checkout_remote_datasource.dart';
import 'checkout_repository.dart';

class CheckoutRepositoryImpl
    implements CheckoutRepository {

  final CheckoutLocalDatasource local;
  final CheckoutRemoteDatasource remote;

  CheckoutRepositoryImpl({
    required this.local,
    required this.remote,
  });

  @override
  Future<String?> getCoupon() {
    return local.getCoupon();
  }

  @override
  Future<void> saveCoupon(
      String code,
      ) {
    return local.saveCoupon(code);
  }

  @override
  Future<void> placeOrder(
      OrderRequestModel order,
      ) {
    return remote.placeOrder(order);
  }
}