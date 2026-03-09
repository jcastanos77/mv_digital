import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class AdminInvitationsPage extends StatelessWidget {
  const AdminInvitationsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go("/admin/create");
        },
        child: const Icon(Icons.add),
      ),

      body: StreamBuilder(

        stream: FirebaseFirestore.instance
            .collection("invitations")
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(

            itemCount: docs.length,

            itemBuilder: (context, index) {

              final data = docs[index].data();
              final id = docs[index].id;

              return ListTile(

                title: Text(data["title"] ?? ""),

                subtitle: Text(
                  "mv-digital.com/invitation/$id",
                ),

                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/admin/edit/$id",
                    );
                  },
                ),

              );
            },
          );
        },
      ),
    );
  }
}