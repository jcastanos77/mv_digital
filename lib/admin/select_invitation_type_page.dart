import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectInvitationTypePage extends StatelessWidget {
  const SelectInvitationTypePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F7),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "¿Qué quieres crear?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 40),

              /// BODAS / XV
              _card(
                title: "Bodas / XV",
                onTap: () {
                  context.go("/admin/create"); // tu page actual
                },
              ),

              const SizedBox(height: 20),

              /// CUMPLEAÑOS
              _card(
                title: "Cumpleaños",
                onTap: () {
                  context.go("/admin/create-birthday");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(.05),
            )
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}