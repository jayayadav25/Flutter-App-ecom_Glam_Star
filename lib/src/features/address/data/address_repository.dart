import 'package:hive/hive.dart';
import '../../../core/models/address_model.dart';

class AddressRepository {
  late Box box;

  Future<void> init() async {
    box = Hive.isBoxOpen('addresses')
        ? Hive.box('addresses')
        : await Hive.openBox('addresses');
  }

  // Get all addresses
  List<AddressModel> getAll() {
    return box.keys.map((key) {
      final data = box.get(key);

      return AddressModel.fromMap(
        key.toString(), //
        Map<String, dynamic>.from(data),
      );
    }).toList();
  }

  // Save / Update address
  Future<void> save(AddressModel address) async {
    await box.put(address.id, address.toMap());
  }

  // Delete address
  Future<void> delete(String id) async {
    await box.delete(id);
  }
}
