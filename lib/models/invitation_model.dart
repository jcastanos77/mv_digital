class InvitationModel {

  final String id;
  final String template;

  /// HERO
  final String title;
  final String heroImage;
  final DateTime eventDate;
  final String eventTime;

  /// TEXTO / FRASE
  final String quote;

  /// UBICACION GENERAL
  final String location;

  /// CEREMONIA
  final String ceremonyPlace;
  final String ceremonyTime;
  final String ceremonyImage;
  final String ceremonyMaps;

  /// RECEPCION
  final String receptionPlace;
  final String receptionTime;
  final String receptionImage;
  final String receptionMaps;

  /// DRESS CODE
  final String dressCode;

  /// GALERIA
  final List<String> gallery;

  InvitationModel({
    required this.id,
    required this.template,
    required this.title,
    required this.heroImage,
    required this.eventDate,
    required this.eventTime,
    required this.quote,
    required this.location,
    required this.ceremonyPlace,
    required this.ceremonyTime,
    required this.ceremonyImage,
    required this.ceremonyMaps,
    required this.receptionPlace,
    required this.receptionTime,
    required this.receptionImage,
    required this.receptionMaps,
    required this.dressCode,
    required this.gallery,
  });

  factory InvitationModel.fromMap(String id, Map<String, dynamic> map) {

    return InvitationModel(

      id: id,
      template: map['template'] ?? "",

      title: map['title'] ?? "",
      heroImage: map['heroImage'] ?? "",

      eventDate: DateTime.parse(map['eventDate']),
      eventTime: map['eventTime'] ?? "",

      quote: map['quote'] ?? "",

      location: map['location'] ?? "",

      ceremonyPlace: map['ceremonyPlace'] ?? "",
      ceremonyTime: map['ceremonyTime'] ?? "",
      ceremonyImage: map['ceremonyImage'] ?? "",
      ceremonyMaps: map['ceremonyMaps'] ?? "",

      receptionPlace: map['receptionPlace'] ?? "",
      receptionTime: map['receptionTime'] ?? "",
      receptionImage: map['receptionImage'] ?? "",
      receptionMaps: map['receptionMaps'] ?? "",

      dressCode: map['dressCode'] ?? "",

      gallery: List<String>.from(map['gallery'] ?? []),
    );

  }

}