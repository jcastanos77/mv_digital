import 'package:flutter/material.dart';
import 'package:mv_digital/models/invitation_model.dart';
import 'package:mv_digital/themes/invitation_theme.dart';

import '../xv/fullscreen_gallery.dart';

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

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.gallery.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: .8,
            ),

            itemBuilder: (context, index) {

              final image = data.gallery[index];

              return GestureDetector(
                onTap: () {

                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 350),
                      pageBuilder: (_, animation, __) {

                        return FadeTransition(
                          opacity: animation,
                          child: FullscreenGallery(
                            images: data.gallery,
                            initialIndex: index,
                          ),
                        );

                      },
                    ),
                  );

                },

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),

                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.low,
                    cacheWidth: 900,
                  ),

                ),
              );

            },
          )

        ],
      ),
    );
  }
}