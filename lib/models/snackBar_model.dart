class SnackBarData {

  final String title;
  final String subtitle;
  final String startTime;
  final String endTime;

  final bool snackBar;
  final bool maruchanes;
  final bool elotes;

  const SnackBarData({
    required this.title,
    required this.subtitle,
    required this.startTime,
    required this.endTime,
    this.snackBar = false,
    this.maruchanes = false,
    this.elotes = false,
  });

  factory SnackBarData.fromJson(Map<String, dynamic> json) {
    return SnackBarData(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      snackBar: json['snackBar'] ?? false,
      maruchanes: json['maruchanes'] ?? false,
      elotes: json['elotes'] ?? false,
    );
  }
}