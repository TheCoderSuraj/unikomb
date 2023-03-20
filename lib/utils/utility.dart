import 'package:intl/intl.dart';

String convertDateToString(DateTime d) {
  final sdf = DateFormat('dd MMM yyyy');
  return sdf.format(d);
}
