import 'package:intl/intl.dart';

class DateTimeUtil {
  static String getCurrentDateTime() => //* Get current DateTime
      DateTime.now()
          .toString()
          .substring(0, 19); //* Substring to remove milliseconds

  static String getCurrentDate() => //* Get current DateTime
      DateTime.now()
          .toString()
          .substring(0, 10); //* Substring to remove milliseconds

  static DateTime convertToDateOnly(String date) => //* Get current DateTime
      DateTime.parse(
        date.toString().substring(0, 10),
      ); //* Substring to remove milliseconds

  static String convertToHumanReadableDate(String date) =>
      //* Get current DateTime
      DateFormat.yMMMd().format(DateTime.parse(date.toString()));

  static String convertToHumanReadable24HrTime(String date) =>
      DateFormat('hh:mm').format(DateTime.parse(date.toString()));
}
