extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
  String splitCapital() {
    RegExp exp = RegExp(r"[A-Z](?:[a-z]+|[A-Z]*(?=[A-Z]|))");
    Iterable<Match> matches = exp.allMatches(this);
    var list = matches.map((e) => (e.group(0)));
    return list.join(" ");
  }
}