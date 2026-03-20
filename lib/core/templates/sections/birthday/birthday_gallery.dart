import 'package:flutter/material.dart';
import 'package:mv_digital/models/invitation_model.dart';
import 'package:mv_digital/themes/invitation_theme.dart';

class BirthdayGallery extends StatelessWidget {

  final InvitationModel data;
  final InvitationTheme theme;

  const BirthdayGallery({
    super.key,
    required this.data,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {

    if (data.gallery.isEmpty) {
      return const SizedBox();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 90,
        horizontal: 20,
      ),
      color: Colors.grey[100],

      child: Column(
        children: [

          Text(
            "Galería",
            style: TextStyle(
              fontFamily: theme.fontFamily,
              fontSize: 36,
              color: theme.primaryColor,
            ),
          ),

          const SizedBox(height: 60),

          LayoutBuilder(
            builder: (context, constraints) {

              int columns = 2;

              if (constraints.maxWidth > 900) {
                columns = 4;
              } else if (constraints.maxWidth > 600) {
                columns = 3;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.gallery.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {

                  final image = data.gallery[index];

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  );

                },
              );

            },
          )

        ],
      ),
    );
  }
}