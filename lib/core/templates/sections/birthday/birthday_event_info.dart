import 'package:flutter/material.dart';
import 'package:mv_digital/models/invitation_model.dart';
import 'package:mv_digital/themes/invitation_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class BirthdayEventInfo extends StatelessWidget {

  final InvitationModel data;
  final InvitationTheme theme;

  const BirthdayEventInfo({
    super.key,
    required this.data,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 90,
        horizontal: 20,
      ),
      color: Colors.white,

      child: Column(
        children: [

          Text(
            "Detalles del evento",
            style: TextStyle(
              fontFamily: theme.fontFamily,
              fontSize: 36,
              color: theme.primaryColor,
            ),
          ),

          const SizedBox(height: 60),

          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [

              _infoCard(
                icon: Icons.calendar_today,
                title: "Fecha",
                value: "${data.eventDate.day}/${data.eventDate.month}/${data.eventDate.year}",
              ),

              _infoCard(
                icon: Icons.access_time,
                title: "Hora",
                value: data.eventTime,
              ),

              _infoCard(
                icon: Icons.location_on,
                title: "Lugar",
                value: data.receptionPlace,
              ),

            ],
          ),

          const SizedBox(height: 50),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 18,
              ),
            ),
            onPressed: () async {

              final uri = Uri.parse(data.receptionMaps);

              if (await canLaunchUrl(uri)) {
                launchUrl(uri);
              }

            },
            child: Text(
              "Ver ubicación",
              style: TextStyle(
                fontFamily: theme.fontFamily,
                color: theme.secondaryColor,
                fontSize: 16,
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {

    return Column(
      children: [

        Icon(
          icon,
          size: 40,
          color: theme.primaryColor,
        ),

        const SizedBox(height: 10),

        Text(
          title,
          style: TextStyle(
            fontFamily: theme.fontFamily,
            fontSize: 18,
            color: theme.primaryColor,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: theme.fontFamily,
            fontSize: 16,
            color: Colors.grey[700],
          ),
        )

      ],
    );
  }

}