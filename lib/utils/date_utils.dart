import 'package:intl/intl.dart';

List<String> unixToDate(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final formatter = DateFormat('dd/MM/yyyy');
  final timeFormat = DateFormat('h:mm a');
  final onlyTime = timeFormat.format(date.toLocal());
  final nowFormatted = formatter.format(date.toLocal());
  return [nowFormatted, onlyTime.toLowerCase()];
}
