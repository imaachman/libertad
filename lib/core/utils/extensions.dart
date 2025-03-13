import 'package:libertad/data/models/issue_status.dart';

extension DateTimeExtension on DateTime {
  String monthToWord() {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'Unknown';
    }
  }

  String appendOrdinals() {
    final int day = this.day;
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  String get prettifyDate => '${monthToWord()} ${appendOrdinals()}, $year';

  String get prettifyDateShort => '${monthToWord()} ${appendOrdinals()}';

  String get prettifyDateAndTime =>
      '$hour:$minute, ${monthToWord()} ${appendOrdinals()}, $year';

  String get prettifyDateSmart {
    if (year == DateTime.now().year) {
      return prettifyDateShort;
    } else {
      return prettifyDate;
    }
  }
}

extension StatusExtension on IssueStatus {
  bool get isIssued => this == IssueStatus.issued;
  bool get isAvailable => this == IssueStatus.available;
}
