import 'package:flutter/material.dart';
import 'admin_invitations_page.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  int index = 0;

  final pages = const [
    AdminInvitationsPage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("MV Digital Admin"),
      ),

      body: Row(
        children: [

          /// SIDEBAR
          NavigationRail(

            selectedIndex: index,

            groupAlignment: -1,

            onDestinationSelected: (i) {
              setState(() {
                index = i;
              });
            },

            labelType: NavigationRailLabelType.all,

            destinations: const [

              NavigationRailDestination(
                icon: Icon(Icons.card_giftcard),
                label: Text("Invitaciones"),
              ),

            ],

          ),

          const VerticalDivider(width: 1),

          /// CONTENT
          Expanded(
            child: pages[index],
          )

        ],
      ),

    );

  }
}