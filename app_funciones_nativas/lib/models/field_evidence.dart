import 'dart:typed_data';

class FieldEvidence {
  const FieldEvidence({
    required this.latitude,
    required this.longitude,
    required this.capturedAt,
    required this.imageBytes,
  });

  final double latitude;
  final double longitude;
  final DateTime capturedAt;
  final Uint8List imageBytes;
}
