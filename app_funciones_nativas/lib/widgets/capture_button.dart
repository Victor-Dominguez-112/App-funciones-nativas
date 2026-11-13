import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  const CaptureButton({
    required this.isCapturing,
    required this.onPressed,
    super.key,
  });

  final bool isCapturing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: isCapturing
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.add_a_photo_outlined),
        label: Text(
          isCapturing ? 'Registrando evidencia...' : 'Registrar Evidencia',
        ),
        style: FilledButton.styleFrom(
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
