import 'package:hive/hive.dart';
import '../../../core/models/address_model.dart';

class AddressLocalRepository {
  static const boxName = "addresses";

  late Box box;

  Future<void> init() async {
    box = await Hive.openBox(boxName);
  }

  Future<void> cacheAddresses(List<AddressModel> addresses,) async {
    final data = addresses.map((e) => e.toMap()).toList();
    await box.put("cached", data);
  }

  List<AddressModel> getCachedAddresses() {
    final raw = box.get("cached", defaultValue: []);
    return (raw as List).map((e) => AddressModel.fromMap(
        e['id'],
        Map<String, dynamic>.from(e),
      ),
    )
        .toList();
  }
}