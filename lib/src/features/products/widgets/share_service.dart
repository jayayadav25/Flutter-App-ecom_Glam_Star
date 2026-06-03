import 'package:share_plus/share_plus.dart';

class ShareService {
  static Future<void> shareProduct({
    required String title,
    required int price,
  }) async {
    await SharePlus.instance.share(
      ShareParams(
          text: '$title '
              'Only ₹$price on Glam Star',
      ),
    );
  }
}