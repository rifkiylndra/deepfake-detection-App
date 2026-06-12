import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../providers/forensic_provider.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8fafc), // Background Light
      appBar: AppBar(
        backgroundColor: const Color(0xff0f172a), // Primary Dark Slate
        elevation: 0,
        title: Text(
          "Workspace Analisis",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<ForensicProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Error Alert Box
                if (provider.errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xfffef2f2), // Light Red
                      border: Border.all(color: const Color(0xfffca5a5)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Color(0xffef4444)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            provider.errorMessage!,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xffb91c1c),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                
                // Image Preview dashed box
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x05000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: provider.selectedImage != null
                        ? Image.file(
                            provider.selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                        : CustomPaint(
                            painter: DashedBorderPainter(
                              color: const Color(0xffcbd5e1),
                              strokeWidth: 2,
                              gap: 6,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.cloud_upload_outlined,
                                      size: 56,
                                      color: Color(0xff64748b), // Muted Text
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Belum Ada Media Terpilih",
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff0f172a),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Silakan ambil foto wajah langsung menggunakan kamera, atau pilih gambar wajah tunggal dari galeri handphone Anda.",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        color: const Color(0xff64748b),
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 28),
                
                // Camera & Gallery selectors
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: provider.isLoading
                            ? null
                            : () => provider.selectImage(ImageSource.camera),
                        icon: const Icon(Icons.camera_alt_outlined, size: 18),
                        label: Text(
                          "Ambil Kamera",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0f766e), // Deep Teal
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: provider.isLoading
                            ? null
                            : () => provider.selectImage(ImageSource.gallery),
                        icon: const Icon(Icons.photo_library_outlined, size: 18),
                        label: Text(
                          "Buka Galeri",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0f766e), // Deep Teal
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                
                // Run Forensic Analysis button
                ElevatedButton(
                  onPressed: (provider.selectedImage == null || provider.isLoading)
                      ? null
                      : () async {
                          final success = await provider.uploadAndDetect();
                          if (success && context.mounted) {
                            Navigator.pushNamed(context, '/result');
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0f172a), // Primary Dark Slate
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xffe2e8f0),
                    disabledForegroundColor: const Color(0xff94a3b8),
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 0,
                  ),
                  child: provider.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          "JALANKAN ANALISIS FORENSIK",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Custom Painter to draw a clean dashed border
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    
    // Define rounded rectangle path matching Card radius 12
    const double radius = 12.0;
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(radius),
    ));

    // Calculate dashed effect path
    final Path dashedPath = Path();
    double distance = 0.0;
    for (final PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        final double len = gap;
        dashedPath.addPath(
          measurePath.extractPath(distance, distance + len),
          Offset.zero,
        );
        distance += len * 2;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
