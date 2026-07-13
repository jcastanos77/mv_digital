import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BaptismEventDetailsSection extends StatelessWidget {
  final String ceremonyPlace;
  final String ceremonyTime;
  final String ceremonyMaps;

  final String? receptionPlace;
  final String? receptionTime;
  final String? receptionMaps;

  const BaptismEventDetailsSection({
    super.key,
    required this.ceremonyPlace,
    required this.ceremonyTime,
    required this.ceremonyMaps,
    this.receptionPlace,
    this.receptionTime,
    this.receptionMaps,
  });

  bool get _hasReception =>
      receptionPlace != null &&
          receptionPlace!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Text(
            "DETALLES DEL EVENTO",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 3,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 40),

          EventCard(
            icon: Icons.church,
            title: "Ceremonia",
            place: ceremonyPlace,
            time: ceremonyTime,
            maps: ceremonyMaps,
          ),

          if (_hasReception) ...[
            const SizedBox(height: 30),

            EventCard(
              icon: Icons.celebration_outlined,
              title: "Recepción",
              place: receptionPlace!,
              time: receptionTime ?? '',
              maps: receptionMaps ?? '',
            ),
          ],
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String place;
  final String time;
  final String maps;

  const EventCard({
    super.key,
    required this.icon,
    required this.title,
    required this.place,
    required this.time,
    required this.maps,
  });

  Future<void> _openMaps() async {
    final uri = Uri.parse(maps);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: const Color(0xFFF7F3EE),
            child: Icon(
              icon,
              color: const Color(0xFFD4AF37),
              size: 30,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 15,
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            place,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D2D2D),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            time,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _openMaps,
              icon: const Icon(Icons.location_on_outlined),
              label: const Text("Cómo llegar"),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}