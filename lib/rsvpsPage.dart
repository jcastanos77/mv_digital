import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RsvpsPage extends StatelessWidget {
  final String slug;

  const RsvpsPage({
    super.key,
    required this.slug,
  });

  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance
        .collection('invitations')
        .doc(slug)
        .collection('rsvps')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return Scaffold(
      backgroundColor: const Color(0xffF7F4F2),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final docs = snapshot.data!.docs;

            int confirmados = 0;
            int noVan = 0;
            int total = 0;

            for (final item in docs) {
              final data =
              item.data() as Map<String, dynamic>;

              final invitados =
              (data['invitados'] ?? 0) as int;

              if (data['asistencia'] == 'Sí') {
                confirmados++;
                total += invitados;
              } else {
                noVan++;
              }
            }

            return Center(
              child: ConstrainedBox(
                constraints:
                const BoxConstraints(maxWidth: 1180),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      /// HEADER
                      Row(
                        children: [
                          Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                  18),
                              color: Colors.black,
                            ),
                            child: const Icon(
                              Icons.groups_rounded,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Confirmaciones",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight:
                                  FontWeight.w700,
                                  color:
                                  Color(0xff111111),
                                ),
                              ),
                              Text(
                                slug,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 28),

                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 1.9,
                        children: [

                          _miniCard(
                            "Confirmados",
                            "$confirmados",
                            Icons.check_circle,
                            Colors.green,
                          ),

                          _miniCard(
                            "No asistirán",
                            "$noVan",
                            Icons.cancel,
                            Colors.red,
                          ),

                          _miniCard(
                            "Personas",
                            "$total",
                            Icons.groups,
                            Colors.amber,
                          ),

                          _miniCard(
                            "Respuestas",
                            "${docs.length}",
                            Icons.mail,
                            Colors.blue,
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      const Text(
                        "Listado",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(.06),
                              blurRadius: 18,
                              offset:
                              const Offset(0, 10),
                            )
                          ],
                        ),
                        child: Column(
                          children: List.generate(
                            docs.length,
                                (i) {
                              final data =
                              docs[i].data()
                              as Map<String,
                                  dynamic>;

                              final nombre =
                                  data['nombre'] ?? '';
                              final invitados =
                              data['invitados']
                                  .toString();
                              final si =
                                  data['asistencia'] ==
                                      'Sí';

                              return Container(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal: 22,
                                  vertical: 18,
                                ),
                                decoration:
                                BoxDecoration(
                                  border: i ==
                                      docs.length -
                                          1
                                      ? null
                                      : Border(
                                      bottom:
                                      BorderSide(
                                        color: Colors
                                            .grey
                                            .shade200,
                                      )),
                                ),
                                child: Row(
                                  children: [

                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor:
                                      si
                                          ? const Color(
                                          0xffECFDF3)
                                          : const Color(
                                          0xffFEF2F2),
                                      child: Text(
                                        nombre[0]
                                            .toUpperCase(),
                                        style:
                                        TextStyle(
                                          color: si
                                              ? const Color(
                                              0xff16A34A)
                                              : const Color(
                                              0xffDC2626),
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                        width: 16),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            nombre,
                                            style:
                                            const TextStyle(
                                              fontSize:
                                              17,
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                            ),
                                          ),
                                          const SizedBox(
                                              height:
                                              4),
                                          Text(
                                            "$invitados invitados",
                                            style:
                                            TextStyle(
                                              color: Colors
                                                  .grey[
                                              700],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      padding:
                                      const EdgeInsets
                                          .symmetric(
                                        horizontal:
                                        14,
                                        vertical:
                                        8,
                                      ),
                                      decoration:
                                      BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            30),
                                        color: si
                                            ? const Color(
                                            0xffECFDF3)
                                            : const Color(
                                            0xffFEF2F2),
                                      ),
                                      child: Text(
                                        si
                                            ? "Confirmó"
                                            : "No irá",
                                        style:
                                        TextStyle(
                                          fontWeight:
                                          FontWeight
                                              .w700,
                                          color: si
                                              ? const Color(
                                              0xff16A34A)
                                              : const Color(
                                              0xffDC2626),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _kpiCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(.12),
              borderRadius:
              BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _miniCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [

          Icon(icon, color: color, size: 22),

          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}