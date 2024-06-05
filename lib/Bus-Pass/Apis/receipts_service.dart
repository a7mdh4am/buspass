import 'dart:convert';
import 'package:http/http.dart' as http;

class ReceiptService {
  static Future<List<Map<String, dynamic>>> getReceiptsByPassengerId(
      int passengerId) async {
    final url =
        'http://busspass.somee.com/api/Booking/GetBookingByPassangerId/$passengerId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => json as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load receipts');
      }
    } catch (e) {
      throw Exception('Failed to load receipts: $e');
    }
  }
}
