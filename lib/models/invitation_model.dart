import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mv_digital/models/snackBar_model.dart';

class InvitationModel {

  final String id;
  final String template;
  final String theme;
  /// HERO
  final String title;
  final String heroImage;
  final DateTime eventDate;
  final String eventTime;
  final String infoAditional;
  /// TEXTO / FRASE
  final String quote;
  final String? giftTitle;
  final String? giftDescription;
  final bool? showGift;

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

  /// BAUTIZO
  final String? father;
  final String? mother;
  List<String>? godParents;
  final String? bibleVerse;
  final String? titleGift;
  final String? descriptionGift;

  /// GALERIA
  final List<String> gallery;

  final SnackBarData? snackBar;

  InvitationModel({
    required this.id,
    required this.template,
    required this.theme,
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
    required this.infoAditional,
    required this.snackBar,
    this.father,
    this.mother,
    this.godParents,
    this.bibleVerse,
    this.descriptionGift,
    this.titleGift,
    this.giftDescription,
    this.giftTitle,
    this.showGift
  });

  factory InvitationModel.fromMap(String id, Map<String, dynamic> map) {

    return InvitationModel(

      id: id,
      template: map['template'] ?? "",
      theme: map['theme'] ?? "",
      title: map['title'] ?? "",
      heroImage: map['heroImage'] ?? "",

      eventDate:  (map['eventDate'] as Timestamp).toDate(),
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
      infoAditional: map['infoAditional'] ?? "",
      gallery: List<String>.from(map['gallery'] ?? []),
      snackBar: map['snackBar'] != null
          ? SnackBarData.fromJson(map['snackBar'])
          : null,
      father: map['father'],
      mother: map['mother'],
      godParents: List<String>.from(
        map["godParents"] ?? [],
      ),
      bibleVerse: map['bibleVerse'],
      descriptionGift: map['descriptionGift'],
      titleGift: map['titleGift'],
      giftDescription: map['giftDescription'],
      giftTitle: map['giftTitle'],
        showGift: map['showGift'] ?? false
    );

  }

}