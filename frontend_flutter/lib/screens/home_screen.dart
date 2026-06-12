import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/forensic_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8fafc), // Background Light
      appBar: AppBar(
        backgroundColor: const Color(0xff0f172a), // Primary Dark Slate
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.shield, color: Color(0xff10b981), size: 24),
            const SizedBox(width: 8),
            Text(
              "Deepfake Forensic",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined, color: Colors.white),
            onPressed: () {
              // Sign out and return to Login screen
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Consumer<ForensicProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hero Card Banner
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: const Color(0xff0f172a), // Primary Dark Slate
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1a000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Uji Orisinalitas Wajah",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Analisis media secara instan untuk mendeteksi rekayasa manipulasi AI generatif.",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color(0xff94a3b8), // Slate 400
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          provider.resetScan();
                          Navigator.pushNamed(context, '/scan');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff10b981), // Emerald Green
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Deteksi Gambar Sekarang",
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_outlined, size: 16),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                
                // Section Title
                Text(
                  "Metrik & Performa Model v7",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff0f172a),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Grid 2x2 Layout
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.3,
                  children: [
                    // Card 1: Total tested (dynamic)
                    _buildMetricCard(
                      title: "Total Citra Diuji",
                      value: "${provider.totalTestedCount}",
                      icon: Icons.history_edu_outlined,
                      iconColor: const Color(0xff0f766e), // Teal
                    ),
                    // Card 2: Global Accuracy (static)
                    _buildMetricCard(
                      title: "Akurasi Global",
                      value: "70.83%",
                      icon: Icons.check_circle_outline,
                      iconColor: const Color(0xff10b981), // Green
                    ),
                    // Card 3: AUC (static)
                    _buildMetricCard(
                      title: "Area Under Curve",
                      value: "0.7815",
                      icon: Icons.multiline_chart_outlined,
                      iconColor: Colors.orange,
                    ),
                    // Card 4: Average latency (static)
                    _buildMetricCard(
                      title: "Latency Rata-rata",
                      value: "142 ms",
                      icon: Icons.speed_outlined,
                      iconColor: Colors.redAccent,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0a000000), // Card shadow (0x0A000000, 8px blur)
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor, size: 24),
              const Icon(Icons.info_outline, color: Color(0xffcbd5e1), size: 14),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0f172a),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: const Color(0xff64748b), // Muted Text
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
