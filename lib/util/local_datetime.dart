class LocalDatetime {
  static String parseToMinutesSeconds(double totalSeconds){
    final minutes = (totalSeconds~/60);
    final seconds = (totalSeconds%60).round();
    return '$minutes:${seconds.toString().padLeft(2,'0')}';
  }
    static String parseToHourMinutesSeconds(int totalSeconds){
    final hour = (totalSeconds~/3600);
    final minutes = (totalSeconds~/60);
    final seconds = (totalSeconds%60).round();
    return '${hour.toString().padLeft(2,'0')}:${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }
}