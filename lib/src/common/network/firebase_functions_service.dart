import 'package:cloud_functions/cloud_functions.dart';

class FirebaseFunctionsService {
  FirebaseFunctionsService({
    FirebaseFunctions? functions,
  }) : _functions =
      functions ?? FirebaseFunctions.instance;

  final FirebaseFunctions _functions;

  Future<Map<String, dynamic>> callFunction({
    required String functionName,
    Map<String, dynamic>? data,
  }) async {
    try {
      final callable =
      _functions.httpsCallable(functionName);

      final result = await callable.call(data);

      return Map<String, dynamic>.from(
        result.data,
      );
    } on FirebaseFunctionsException catch (e) {
      throw Exception(
        e.message ?? 'Cloud Function Error',
      );
    } catch (e) {
      throw Exception(
        'Unexpected Error: $e',
      );
    }
  }
}