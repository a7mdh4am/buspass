import 'package:intl/intl.dart';

class Date {
  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd MMM , hh:mm a').format(dateTime);
  }
}
