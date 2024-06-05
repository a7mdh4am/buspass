import 'package:http/http.dart' as http;

class DeleteTrip {
  final String apiUrl = "http://busspass.somee.com/api/Trip";

  Future<void> deleteTrip(String tripId) async {
    final response = await http.delete(Uri.parse('$apiUrl/$tripId'));

    if (response.statusCode == 200) {
      print('Trip with ID $tripId deleted successfully.');
    } else {
      print(
          'Failed to delete trip with ID $tripId. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}
