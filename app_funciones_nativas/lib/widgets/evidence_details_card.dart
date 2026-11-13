import 'package:flutter/material.dart';
import '../models/field_evidence.dart';

class EvidenceDetailsCard extends StatelessWidget {
  const EvidenceDetailsCard({required this.evidence, super.key});

  final FieldEvidence evidence;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Image.memory(
              evidence.imageBytes,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image_outlined, size: 40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Datos del registro',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                _EvidenceDetail(
                  icon: Icons.my_location,
                  label: 'Latitud',
                  value: evidence.latitude.toStringAsFixed(6),
                ),
                const SizedBox(height: 12),
                _EvidenceDetail(
                  icon: Icons.location_on_outlined,
                  label: 'Longitud',
                  value: evidence.longitude.toStringAsFixed(6),
                ),
                const SizedBox(height: 12),
                _EvidenceDetail(
                  icon: Icons.schedule,
                  label: 'Fecha y hora',
                  value: _formatCapturedAt(evidence.capturedAt),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCapturedAt(DateTime timestamp) {
    final localTime = timestamp.toLocal();
    final date = '${localTime.day.toString().padLeft(2, '0')}/' '${localTime.month.toString().padLeft(2, '0')}/' '${localTime.year}';
    final time = '${localTime.hour.toString().padLeft(2, '0')}:' '${localTime.minute.toString().padLeft(2, '0')}:' '${localTime.second.toString().padLeft(2, '0')}';
    return '$date, $time';
  }
}

class _EvidenceDetail extends StatelessWidget {
  const _EvidenceDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: colors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}