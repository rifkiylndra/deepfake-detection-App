import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import '../utils/database_helper.dart';

class ForensicProvider with ChangeNotifier {
  final Dio _dio = Dio();
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _predictionResult;
  List<Map<String, dynamic>> _chatHistory = [];
  int _totalTestedCount = 0;

  // Getters
  File? get selectedImage => _selectedImage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get predictionResult => _predictionResult;
  List<Map<String, dynamic>> get chatHistory => _chatHistory;
  int get totalTestedCount => _totalTestedCount;

  // Dynamic host selection: 10.0.2.2 for Android emulator, 127.0.0.1 for iOS/others
  String get baseUrl {
    if (Platform.isAndroid) {
      return "https://rifkiylndra-deepfake-forensic-api.hf.space";
    }
    return "https://rifkiylndra-deepfake-forensic-api.hf.space";
  }

  ForensicProvider() {
    _loadStats();
  }

  // Load stats from local SQLite database
  Future<void> _loadStats() async {
    try {
      _totalTestedCount = await DatabaseHelper.instance.getLogsCount();
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading stats from SQLite: $e");
    }
  }

  // Set the selected image file directly or via ImagePicker
  Future<void> selectImage(ImageSource source) async {
    _errorMessage = null;
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 90,
      );
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        _predictionResult = null; // Clear previous results
        _chatHistory.clear(); // Reset agent conversation
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = "Gagal mengambil gambar: $e";
      notifyListeners();
    }
  }

  // Upload the selected image to the FastAPI server for deepfake prediction
  Future<bool> uploadAndDetect() async {
    if (_selectedImage == null) {
      _errorMessage = "Pilih gambar terlebih dahulu.";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    _predictionResult = null;
    notifyListeners();

    try {
      final String filename = p.basename(_selectedImage!.path);
      final FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          _selectedImage!.path,
          filename: filename,
        ),
      });

      final response = await _dio.post(
        "$baseUrl/api/v1/detect",
        data: formData,
        options: Options(
          sendTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        _predictionResult = Map<String, dynamic>.from(response.data);

        // Save test session log into SQLite local database
        await DatabaseHelper.instance.insertLog({
          "filename": filename,
          "prediction": _predictionResult!["prediction"],
          "confidence_score": _predictionResult!["confidence_score"],
          "timestamp": DateTime.now().toIso8601String(),
        });

        // Refresh local stats count
        await _loadStats();

        // Clear old chat log and set initial context prompt
        _chatHistory = [
          {
            "sender": "agent",
            "text":
                "Halo! Saya Antigravity, konsultan forensik digital Anda. "
                "Citra wajah '${filename}' Anda telah dianalisis oleh Model Deep Learning v7 kami. "
                "Hasil klasifikasi terdeteksi sebagai ${_predictionResult!["prediction"]} dengan tingkat keyakinan "
                "${(_predictionResult!["confidence_score"] * 100).toStringAsFixed(2)}%.\n\n"
                "Ada yang ingin Anda tanyakan seputar keamanan siber atau analisis citra ini?",
          },
        ];

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        throw Exception("Server mengembalikan status ${response.statusCode}");
      }
    } on DioException catch (dioError) {
      if (dioError.type == DioExceptionType.connectionTimeout ||
          dioError.type == DioExceptionType.receiveTimeout) {
        _errorMessage =
            "Koneksi ke server timeout. Pastikan server backend Anda berjalan.";
      } else {
        _errorMessage = "Koneksi API Gagal: ${dioError.message}";
      }
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = "Terjadi kesalahan sistem: $e";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Consult with the Antigravity agent using context injection payload
  Future<void> sendAgentConsult(String userMessage) async {
    if (userMessage.trim().isEmpty || _predictionResult == null) return;

    // Append user query to chat history
    _chatHistory.add({"sender": "user", "text": userMessage});

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final filename = p.basename(_selectedImage!.path);

      // Constructing JSON Payload as defined in AGENTS.md section 04
      final Map<String, dynamic> requestPayload = {
        "session_id": "sess_${DateTime.now().millisecondsSinceEpoch}",
        "media_metadata": {
          "filename": filename,
          "resolution": "299x299",
          "source": "camera",
        },
        "inference_result": {
          "prediction": _predictionResult!["prediction"],
          "confidence_score": _predictionResult!["confidence_score"],
        },
        "user_message": userMessage,
      };

      final response = await _dio.post(
        "$baseUrl/api/v1/agent/consult",
        data: requestPayload,
        options: Options(
          headers: {"Content-Type": "application/json"},
          sendTimeout: const Duration(seconds: 25),
          receiveTimeout: const Duration(seconds: 25),
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final payloadData = response.data["payload"];
        final String agentReplyText = payloadData["agent_conversational_reply"];

        // Append response reply to chat history
        _chatHistory.add({"sender": "agent", "text": agentReplyText});
      } else {
        throw Exception("Gagal menghubungi Antigravity Agent.");
      }
    } on DioException catch (dioError) {
      _chatHistory.add({
        "sender": "agent",
        "text":
            "Maaf, koneksi saya dengan server terganggu (${dioError.message}). Mohon coba tanyakan kembali sebentar lagi.",
      });
    } catch (e) {
      _chatHistory.add({
        "sender": "agent",
        "text": "Terjadi kesalahan internal sistem: $e",
      });
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear current selected image and scan session
  void resetScan() {
    _selectedImage = null;
    _predictionResult = null;
    _chatHistory.clear();
    _errorMessage = null;
    notifyListeners();
  }
}
