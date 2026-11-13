import 'package:flutter/material.dart';
import 'screens/evidence_screen.dart'; // Importamos tu pantalla principal

void main() {
  runApp(const EvidenciaApp());
}

class EvidenciaApp extends StatelessWidget {
  const EvidenciaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evidencias de Campo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      // Llamamos a la pantalla que creaste
      home: const EvidenceScreen(),
    );
  }
}