import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RsvpsPage extends StatelessWidget {
  final String slug;

  const RsvpsPage({
    super.key,
    required this.slug,
  });

  // =========================
  // PALETA MINIMALISTA
  // =========================

  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color surfaceColor = Colors.white;

  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);

  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color accentColor = Color(0xFF475569);

  static const Color successBg = Color(0xFFF0FDF4);
  static const Color successText = Color(0xFF166534);

  static const Color dangerBg = Color(0xFFFEF2F2);
  static const Color dangerText = Color(0xFF991B1B);

  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance
        .collection('invitations')
        .doc(slug)
        .collection('rsvps')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return _errorState();
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: accentColor,
                ),
              );
            }

            final docs = snapshot.data!.docs;

            int confirmados = 0;
            int noVan = 0;
            int personas = 0;

            for (final item in docs) {
              final data = item.data() as Map<String, dynamic>;

              final invitados = (data['invitados'] ?? 0) as int;

              if (data['asistencia'] == 'Sí') {
                confirmados++;
                personas += invitados;
              } else {
                noVan++;
              }
            }

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1180,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    20,
                    20,
                    32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(context),

                      const SizedBox(height: 32),

                      _sectionHeader(
                        title: 'Resumen',
                        subtitle:
                        'Información general de las confirmaciones',
                      ),

                      const SizedBox(height: 16),

                      _statsGrid(
                        context,
                        confirmados: confirmados,
                        noVan: noVan,
                        personas: personas,
                        respuestas: docs.length,
                      ),

                      const SizedBox(height: 40),

                      _sectionHeader(
                        title: 'Confirmaciones',
                        subtitle:
                        'Listado de respuestas recibidas',
                      ),

                      const SizedBox(height: 16),

                      if (docs.isEmpty)
                        _emptyState()
                      else
                        _rsvpsList(
                          context,
                          docs,
                        ),
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

  // =========================
  // HEADER
  // =========================

  Widget _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 22,
          ),
          tooltip: 'Regresar',
          style: IconButton.styleFrom(
            backgroundColor: surfaceColor,
            foregroundColor: textPrimary,
            side: const BorderSide(
              color: borderColor,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'Confirmaciones',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: textPrimary,
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          slug,
          style: const TextStyle(
            fontSize: 15,
            color: textSecondary,
          ),
        ),
      ],
    );
  }

  // =========================
  // TITULOS DE SECCIÓN
  // =========================

  Widget _sectionHeader({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: textSecondary,
          ),
        ),
      ],
    );
  }

  // =========================
  // GRID DE ESTADÍSTICAS
  // =========================

  Widget _statsGrid(
      BuildContext context, {
        required int confirmados,
        required int noVan,
        required int personas,
        required int respuestas,
      }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return GridView.count(
          crossAxisCount: isMobile ? 2 : 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: isMobile ? 1.55 : 1.6,
          children: [
            _statCard(
              title: 'Confirmados',
              value: '$confirmados',
              icon: Icons.check_circle_outline,
            ),

            _statCard(
              title: 'No asistirán',
              value: '$noVan',
              icon: Icons.cancel_outlined,
            ),

            _statCard(
              title: 'Personas',
              value: '$personas',
              icon: Icons.people_outline,
            ),

            _statCard(
              title: 'Respuestas',
              value: '$respuestas',
              icon: Icons.mail_outline,
            ),
          ],
        );
      },
    );
  }

  // =========================
  // TARJETA DE ESTADÍSTICA
  // =========================

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: accentColor,
            size: 21,
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: textPrimary,
              height: 1,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // LISTADO DE RSVP
  // =========================

  Widget _rsvpsList(
      BuildContext context,
      List<QueryDocumentSnapshot> docs,
      ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 650;

        return Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: Column(
            children: [
              if (!isMobile) _tableHeader(),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: docs.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    thickness: 1,
                    color: borderColor,
                  );
                },
                itemBuilder: (context, index) {
                  final data =
                  docs[index].data() as Map<String, dynamic>;

                  final nombre =
                  (data['nombre'] ?? '').toString();

                  final invitados =
                  (data['invitados'] ?? 0).toString();

                  final asistencia =
                      data['asistencia'] == 'Sí';

                  if (isMobile) {
                    return _mobileRsvpItem(
                      nombre: nombre,
                      invitados: invitados,
                      asistencia: asistencia,
                    );
                  }

                  return _desktopRsvpItem(
                    nombre: nombre,
                    invitados: invitados,
                    asistencia: asistencia,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================
  // ENCABEZADO DE TABLA
  // =========================

  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              'NOMBRE',
              style: _tableHeaderStyle,
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              'INVITADOS',
              style: _tableHeaderStyle,
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              'ESTADO',
              style: _tableHeaderStyle,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // ITEM DESKTOP
  // =========================

  Widget _desktopRsvpItem({
    required String nombre,
    required String invitados,
    required bool asistencia,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 18,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              nombre.isEmpty ? 'Sin nombre' : nombre,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: textPrimary,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              invitados,
              style: const TextStyle(
                fontSize: 15,
                color: textSecondary,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: _statusBadge(
              asistencia: asistencia,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // ITEM MOBILE
  // =========================

  Widget _mobileRsvpItem({
    required String nombre,
    required String invitados,
    required bool asistencia,
  }) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nombre.isEmpty ? 'Sin nombre' : nombre,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: Text(
                  '$invitados invitados',
                  style: const TextStyle(
                    fontSize: 14,
                    color: textSecondary,
                  ),
                ),
              ),

              _statusBadge(
                asistencia: asistencia,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================
  // BADGE DE ESTADO
  // =========================

  Widget _statusBadge({
    required bool asistencia,
  }) {
    final background =
    asistencia ? successBg : dangerBg;

    final color =
    asistencia ? successText : dangerText;

    final text =
    asistencia ? 'Confirmó' : 'No irá';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  // =========================
  // ESTADO VACÍO
  // =========================

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 42,
            color: textSecondary,
          ),

          SizedBox(height: 16),

          Text(
            'Aún no hay confirmaciones',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),

          SizedBox(height: 6),

          Text(
            'Las respuestas aparecerán aquí.',
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // ERROR
  // =========================

  Widget _errorState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Ocurrió un error al cargar las confirmaciones.',
          style: TextStyle(
            color: textSecondary,
          ),
        ),
      ),
    );
  }

  static const TextStyle _tableHeaderStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: textSecondary,
    letterSpacing: 0.5,
  );
}