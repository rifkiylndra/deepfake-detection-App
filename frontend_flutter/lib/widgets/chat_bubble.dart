import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isAgent;

  const ChatBubble({
    Key? key,
    required this.text,
    required this.isAgent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment:
            isAgent ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAgent) ...[
            CircleAvatar(
              backgroundColor: const Color(0xff0f172a), // Primary Dark Slate
              radius: 16,
              child: const Icon(
                Icons.security,
                size: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isAgent
                    ? const Color(0xfff1f5f9) // Light Grey background
                    : const Color(0xff0f766e), // Deep Teal
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: Radius.circular(isAgent ? 0 : 12),
                  bottomRight: Radius.circular(isAgent ? 12 : 0),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAgent ? "Antigravity Consultant" : "Anda",
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isAgent
                          ? const Color(0xff64748b) // Muted Text
                          : Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      height: 1.4,
                      color: isAgent
                          ? const Color(0xff334155) // Body Text Dark
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isAgent) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: const Color(0xff0f766e), // Deep Teal
              radius: 16,
              child: const Icon(
                Icons.person,
                size: 16,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
