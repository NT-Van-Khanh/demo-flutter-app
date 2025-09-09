class LocalDatetime {
  static String parseToMinutesSeconds(double totalSeconds){
    final minutes = (totalSeconds~/60);
    final seconds = (totalSeconds%60).round();
    return '$minutes:${seconds.toString().padLeft(2,'0')}';
  }
}