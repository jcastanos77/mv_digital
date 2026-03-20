import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

class AdminInvitationsPage extends StatelessWidget {
  const AdminInvitationsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(

      color: const Color(0xffF5F5F7),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Invitaciones",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Administra todas las invitaciones creadas",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),

                  ],
                ),

                /// BOTON CREAR
                ElevatedButton.icon(

                  onPressed: (){
                    context.go("/admin/create");
                  },

                  icon: const Icon(Icons.add, color: Colors.white,),

                  label: const Text("Nueva invitación", style: TextStyle(color: Colors.white,),),

                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                )

              ],
            ),

            const SizedBox(height: 30),

            /// LISTA
            Expanded(
              child: Container(

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),

                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.05),
                    )
                  ],
                ),

                child: StreamBuilder(

                  stream: FirebaseFirestore.instance
                      .collection("invitations")
                      .orderBy("eventDate", descending: true)
                      .snapshots(),

                  builder: (context, snapshot) {

                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final docs = snapshot.data!.docs;

                    if(docs.isEmpty){
                      return Center(
                        child: Text(
                          "No hay invitaciones aún",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(

                      itemCount: docs.length,

                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 14),

                      itemBuilder: (context, index) {

                        final data = docs[index].data();
                        final id = docs[index].id;

                        return _InvitationCard(
                          id: id,
                          title: data["title"] ?? "",
                        );

                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _InvitationCard extends StatelessWidget {

  final String id;
  final String title;

  const _InvitationCard({
    required this.id,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    final url = "https://mvdigital-1befe.web.app/invitation/$id";

    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),

      decoration: BoxDecoration(

        color: const Color(0xffFAFAFA),

        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: const Color(0xffEEEEEE),
        ),

      ),

      child: Row(

        children: [

          /// ICONO
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xffF2F2F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              color: Colors.black87,
              Icons.celebration,
              size: 22,
            ),
          ),

          const SizedBox(width: 20),

          /// INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                SelectableText(
                  url,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(width: 20),

          /// ACTIONS
          Row(
            children: [

              /// COPIAR LINK
              IconButton(
                tooltip: "Copiar link",
                icon: const Icon(Icons.copy),
                onPressed: (){
                  Clipboard.setData(
                    ClipboardData(text: url),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Link copiado"),
                    ),
                  );
                },
              ),

              /// VER INVITACION
              IconButton(
                tooltip: "Ver invitación",
                icon: const Icon(Icons.open_in_new),
                onPressed: (){
                  context.go("/invitation/$id");
                },
              ),

              /// EDITAR
              IconButton(
                tooltip: "Editar",
                icon: const Icon(Icons.edit),
                onPressed: (){
                  context.go("/admin/edit/$id");
                },
              ),

            ],
          )

        ],
      ),
    );
  }
}