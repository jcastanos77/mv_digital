class SnackBarData {

  final String image;
  final String title;
  final String subtitle;
  final String startTime;
  final String endTime;
  final List<String> items;

  const SnackBarData({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.startTime,
    required this.endTime,
    required this.items,
  });

  factory SnackBarData.fromJson(Map<String, dynamic> json) {
    return SnackBarData(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      items: List<String>.from(json['items'] ?? []),
    );
  }
}