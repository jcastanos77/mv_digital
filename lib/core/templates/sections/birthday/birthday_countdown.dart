import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mv_digital/models/invitation_model.dart';
import 'package:mv_digital/themes/invitation_theme.dart';

class BirthdayCountdown extends StatefulWidget {

  final InvitationModel data;
  final InvitationTheme theme;

  const BirthdayCountdown({
    super.key,
    required this.data,
    required this.theme,
  });

  @override
  State<BirthdayCountdown> createState() => _BirthdayCountdownState();
}

class _BirthdayCountdownState extends State<BirthdayCountdown> {

  late Timer timer;
  Duration remaining = Duration.zero;

  @override
  void initState() {
    super.initState();

    calculateRemaining();

    timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        calculateRemaining();
      },
    );
  }

  void calculateRemaining() {

    final now = DateTime.now();
    final event = widget.data.eventDate;

    setState(() {
      remaining = event.difference(now);
    });

  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 80,
      ),
      color: widget.theme.primaryColor,

      child: Column(
        children: [

          Text(
            "Faltan",
            style: TextStyle(
              fontFamily: widget.theme.fontFamily,
              fontSize: 28,
              color: widget.theme.secondaryColor,
            ),
          ),

          const SizedBox(height: 40),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: [

              _timeBox(days, "Días"),
              _timeBox(hours, "Horas"),
              _timeBox(minutes, "Min"),
              _timeBox(seconds, "Seg"),

            ],
          )

        ],
      ),
    );
  }

  Widget _timeBox(int value, String label) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.theme.secondaryColor,
          width: 2,
        ),
      ),
      child: Column(
        children: [

          Text(
            value.toString(),
            style: TextStyle(
              fontFamily: widget.theme.fontFamily,
              fontSize: 32,
              color: widget.theme.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            label,
            style: TextStyle(
              fontFamily: widget.theme.fontFamily,
              fontSize: 14,
              color: widget.theme.secondaryColor,
            ),
          )

        ],
      ),
    );

  }

}