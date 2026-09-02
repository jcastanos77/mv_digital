import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

class AdminInvitationsPage extends StatelessWidget {
  const AdminInvitationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Container(
      color: const Color(0xffF5F5F7),

      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 40,
          vertical: isMobile ? 20 : 30,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// HEADER
            isMobile
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: _CreateButton(),
                ),
              ],
            )
                : Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                _Header(),
                _CreateButton(),
              ],
            ),

            const SizedBox(height: 30),

            /// LISTA
            Expanded(
              child: Container(
                padding: EdgeInsets.all(
                  isMobile ? 12 : 24,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    isMobile ? 16 : 24,
                  ),

                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.05),
                    ),
                  ],
                ),

                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("invitations")
                      .orderBy(
                    "eventDate",
                    descending: true,
                  )
                      .snapshots(),

                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final docs = snapshot.data!.docs;

                    if (docs.isEmpty) {
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
                        final data = docs[index].data()
                        as Map<String, dynamic>;

                        final id = docs[index].id;

                        return _InvitationCard(
                          id: id,
                          title: data["title"] ?? "",
                          views: data["views"] ?? 0,
                          uniqueViews: (data["uniqueViews"] ?? 0) as int,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

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
    );
  }
}
class _CreateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.go("/admin/select-type");
      },

      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),

      label: const Text(
        "Nueva invitación",
        style: TextStyle(
          color: Colors.white,
        ),
      ),

      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 18,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
class _InvitationCard extends StatelessWidget {
  final String id;
  final String title;
  final int views;
  final int uniqueViews;

  const _InvitationCard({
    required this.id,
    required this.title,
    required this.views,
    required this.uniqueViews,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    final url =
        "https://preview.mvdigital.cc/invitation/$id";

    return Container(
      padding: EdgeInsets.all(
        isMobile ? 16 : 24,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(
          isMobile ? 14 : 18,
        ),
        border: Border.all(
          color: const Color(0xffEEEEEE),
        ),
      ),
      child: isMobile
          ? _buildMobile(context, url)
          : _buildDesktop(context, url),
    );
  }

  Widget _buildDesktop(
      BuildContext context,
      String url,
      ) {
    return Row(
      children: [
        _Icon(),
        const SizedBox(width: 20),

        Expanded(
          child: _Info(
            title: title,
            views: views,
            uniqueViews: uniqueViews,
            url: url,
          ),
        ),

        const SizedBox(width: 20),

        _Actions(
          id: id,
          url: url,
        ),
      ],
    );
  }

  Widget _buildMobile(
      BuildContext context,
      String url,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _Icon(),

            const SizedBox(width: 14),

            Expanded(
              child: _Info(
                title: title,
                views: views,
                uniqueViews: uniqueViews,
                url: url,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        const Divider(),

        const SizedBox(height: 8),

        _Actions(
          id: id,
          url: url,
          expanded: true,
        ),
      ],
    );
  }
}

class _Icon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,

      decoration: BoxDecoration(
        color: const Color(0xffF2F2F7),
        borderRadius:
        BorderRadius.circular(12),
      ),

      child: const Icon(
        Icons.celebration,
        color: Colors.black87,
        size: 22,
      ),
    );
  }
}
class _Info extends StatelessWidget {
  final String title;
  final int views;
  final int uniqueViews;
  final String url;

  const _Info({
    required this.title,
    required this.views,
    required this.uniqueViews,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),

        Wrap(
          spacing: 16,
          runSpacing: 6,
          children: [
            _Stat(
              icon: Icons.visibility_outlined,
              label: '$views vistas',
            ),

            _Stat(
              icon: Icons.person_outline,
              label: '$uniqueViews personas',
            ),
          ],
        ),

        const SizedBox(height: 6),

        Text(
          url,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
class _Actions extends StatelessWidget {
  final String id;
  final String url;
  final bool expanded;

  const _Actions({
    required this.id,
    required this.url,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = [
      IconButton(
        tooltip: "Copiar link",
        icon: const Icon(Icons.copy),

        onPressed: () {
          Clipboard.setData(
            ClipboardData(text: url),
          );

          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text("Link copiado"),
            ),
          );
        },
      ),

      IconButton(
        tooltip: "Ver invitación",
        icon: const Icon(Icons.open_in_new),

        onPressed: () {
          context.go("/invitation/$id");
        },
      ),

      IconButton(
        tooltip: "Editar",
        icon: const Icon(Icons.edit),

        onPressed: () {
          context.go("/admin/edit/$id");
        },
      ),
    ];

    if (expanded) {
      return Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceAround,
        children: buttons,
      );
    }

    return Row(
      children: buttons,
    );
  }
}
class _Stat extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Stat({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey.shade600,
        ),

        const SizedBox(width: 5),

        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}