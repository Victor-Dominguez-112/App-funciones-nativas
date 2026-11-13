import 'package:flutter/material.dart';
import '../models/field_evidence.dart';
import '../services/camera_service.dart';
import '../services/location_service.dart';
import '../widgets/capture_button.dart';
import '../widgets/evidence_details_card.dart';

class EvidenceScreen extends StatefulWidget {
  const EvidenceScreen({super.key});

  @override
  State<EvidenceScreen> createState() => _EvidenceScreenState();
}

class _EvidenceScreenState extends State<EvidenceScreen> {
  final _locationService = LocationService();
  final _cameraService = CameraService();

  FieldEvidence? _evidence;
  bool _isCapturing = false;

  Future<void> _registerEvidence() async {
    setState(() => _isCapturing = true);

    try {
      final position = await _locationService.getCurrentPosition();
      if (!mounted) return;

      final image = await _cameraService.takePhoto();
      if (!mounted) return;

      if (image == null) {
        _showMessage('Se canceló la captura de la fotografía.');
        return;
      }

      final imageBytes = await image.readAsBytes();
      if (!mounted) return;

      setState(() {
        _evidence = FieldEvidence(
          latitude: position.latitude,
          longitude: position.longitude,
          capturedAt: DateTime.now(),
          imageBytes: imageBytes,
        );
      });
    } on LocationServiceException catch (error) {
      if (mounted) _showMessage(error.message);
    } on Exception catch (error) {
      if (mounted) {
        _showMessage('No se pudo completar el registro: $error');
      }
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final evidence = _evidence;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Evidencia de campo'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            const SizedBox(height: 24),
            CaptureButton(
              isCapturing: _isCapturing,
              onPressed: _isCapturing ? null : _registerEvidence,
            ),
            const SizedBox(height: 28),
            Text(
              evidence == null ? 'Tu registro' : 'Último registro',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            if (evidence != null)
              EvidenceDetailsCard(evidence: evidence)
            else
              const _EmptyEvidenceCard(),
          ],
        ),
      ),
    );
  }
}

class _EmptyEvidenceCard extends StatelessWidget {
  const _EmptyEvidenceCard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Column(
          children: [
            Icon(
              Icons.photo_camera_back_outlined,
              size: 48,
              color: colors.primary,
            ),
            const SizedBox(height: 12),
            Text(
              'Aún no hay evidencias',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              'Tu foto, ubicación y hora aparecerán aquí.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
