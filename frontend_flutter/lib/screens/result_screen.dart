import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/forensic_provider.dart';
import '../widgets/chat_bubble.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8fafc), // Background Light
      appBar: AppBar(
        backgroundColor: const Color(0xff0f172a), // Primary Dark Slate
        elevation: 0,
        title: Text(
          "Laporan Forensik",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<ForensicProvider>(
        builder: (context, provider, child) {
          final result = provider.predictionResult;
          if (result == null) {
            return Center(
              child: Text(
                "Tidak ada data deteksi.",
                style: GoogleFonts.inter(color: const Color(0xff64748b)),
              ),
            );
          }

          final String prediction = result["prediction"];
          final double confidence = result["confidence_score"];
          final bool isFake = prediction == "FAKE";
          final Color themeColor = isFake
              ? const Color(0xffef4444) // Alert Red
              : const Color(0xff10b981); // Safe Green

          // Auto-scroll on chat history change
          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Summary Verdict Banner & Progress Bar (Top Panel)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x08000000),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Image Thumbnail
                        if (provider.selectedImage != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              provider.selectedImage!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(width: 16),
                        
                        // Verdict Text and Confidence Score
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: themeColor,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  isFake
                                      ? "TERINDIKASI FAKE / MANIPULASI"
                                      : "TERVERIFIKASI REAL / ASLI",
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Tingkat Keyakinan: ${(confidence * 100).toStringAsFixed(2)}%",
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff0f172a),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // Linear Progress Bar representing confidence level
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: confidence,
                        backgroundColor: const Color(0xffe2e8f0),
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),

              // Chat Consulting Layer (Agent chat section)
              Expanded(
                child: Container(
                  color: const Color(0xfff8fafc),
                  child: provider.chatHistory.isEmpty
                      ? Center(
                          child: Text(
                            "Memulai chat dengan konsultan...",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xff64748b),
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.only(top: 12.0, bottom: 20.0),
                          itemCount: provider.chatHistory.length,
                          itemBuilder: (context, index) {
                            final chat = provider.chatHistory[index];
                            final bool isAgentMsg = chat["sender"] == "agent";
                            return ChatBubble(
                              text: chat["text"],
                              isAgent: isAgentMsg,
                            );
                          },
                        ),
                ),
              ),

              // Sticky input text box (Bottom Section)
              Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 10.0,
                  bottom: 12.0,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x08000000),
                      blurRadius: 8,
                      offset: Offset(0, -3),
                    )
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _chatController,
                          textCapitalization: TextCapitalization.sentences,
                          style: GoogleFonts.inter(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: "Konsultasikan mengenai hasil analisis ini...",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xff94a3b8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            filled: true,
                            fillColor: const Color(0xfff1f5f9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSubmitted: (val) {
                            if (provider.isLoading) return;
                            final text = _chatController.text.trim();
                            if (text.isNotEmpty) {
                              provider.sendAgentConsult(text);
                              _chatController.clear();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: const Color(0xff0f766e), // Deep Teal
                        radius: 20,
                        child: provider.isLoading
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.send_outlined,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final text = _chatController.text.trim();
                                  if (text.isNotEmpty) {
                                    provider.sendAgentConsult(text);
                                    _chatController.clear();
                                  }
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
