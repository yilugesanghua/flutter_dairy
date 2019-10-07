class DateUtil {
  static String formatMillisecond(int millisecond, String format) {
    DateTime d = DateTime.fromMillisecondsSinceEpoch(millisecond);
    print("dddd===> $d");
    String s = DateTime.parse(d.toString()).toIso8601String();
    print("ssss===> $s");
    return s;
  }
}
