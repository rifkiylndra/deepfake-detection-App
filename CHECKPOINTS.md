# Progress Checkpoint Tracker — Deepfake Detection App

Dokumen ini berfungsi sebagai papan kontrol (*Task Management Board*) untuk memantau sisa pekerjaan Tugas Besar UAS Image Processing (DIF60202) Universitas Andalas. Target pengumpulan adalah **16 Juni 2026 pukul 23.59 WIB**.

---

## 📊 Ringkasan Status Proyek (Sisa Waktu: 4 Hari)
* **Total Task:** 24
* **Selesai (Done):** 9
* **Dalam Pengerjaan (In Progress):** 2
* **Belum Mulai (To Do):** 13

---

## 🟩 FASE 1: Riset & Eksperimen AI Model (100% DONE)
*Fase pencarian arsitektur terbaik dan penyelesaian kendala teknis training.*

- [x] **M-01:** Literature review topik deepfake detection & analisis gap penelitian.
- [x] **M-02:** Penyiapan cache frame FaceForensics++ C23 dan Celeb-DF v2 (`./cache_v4/`).
- [x] **M-03:** Baseline Model v4 (Xception Baseline - AUC 0.68).
- [x] **M-04:** Eksperimen v5 (EfficientNet-B4 - Gagal akibat data imbalance).
- [x] **M-05:** Eksperimen v6 (Progressive Unfreezing - Mengidentifikasi regresi BatchNorm).
- [x] **M-06:** Eksperimen v6-fix (Frozen BatchNorm Fine-Tuning - Sukses, AUC 0.77).
- [x] **M-07:** Eksperimen v7 (Fix Fase 1 - Sukses Menghasilkan Bobot Terbaik Akhir, AUC 0.7815, Akurasi 70.83%).

---

## 🟦 FASE 2: Blueprint & Dokumentasi Sistem (100% DONE)
*Penyusunan spesifikasi produk agar tidak terjadi over-engineering di sisa waktu kritis.*

- [x] **D-01:** Pembuatan *Product Requirement Document* (`PRD_Deepfake_Detection_Mobile_App.md`).
- [x] **D-02:** Pembuatan Spesifikasi Khusus AI Agent (`AGENTS.md`) untuk Persona Antigravity.
- [x] **D-03:** Pembuatan Panduan Desain & Kit Prompt stitch.ai (`DESIGN.md`).

---

## 🟨 FASE 3: Backend API & Model Server Deployment (HARI 1 — 12 Juni 2026)
*Target: Mengubah model lokal notebook menjadi endpoint API online.*

- [x] **B-01:** Inisialisasi struktur folder backend Python (`/app`, `/weights`).
- [x] **B-02:** Menyalin kelas arsitektur `XceptionFrozenBN` dari notebook v7 ke `model.py`.
- [x] **B-03:** Memindahkan berkas bobot final `model_final.pth` dari folder `./output_v7/` ke direktori backend.
- [x] **B-04:** Membuat fungsi utilitas preprocessing citra (Resize $299 \times 299$ px, normalisasi ImageNet) di `utils.py`.
- [x] **B-05:** Menulis skrip router utama `main.py` (Endpoint `POST /api/v1/detect`) dan konfigurasi CORS.
- [x] **B-06:** Menguji fungsionalitas inferensi backend menggunakan Postman secara lokal.
- [x] **B-07:** Membuat `Dockerfile` dan melakukan deployment online ke Hugging Face Spaces atau Render.

---

## 🟧 FASE 4: Frontend UI Mobile Application (HARI 2 — 13 Juni 2026)
*Target: Ekstraksi wireframe stitch.ai ke dalam widget Flutter.*

- [x] **F-01:** Setup proyek Flutter baru (`flutter create`) dan konfigurasi berkas `pubspec.yaml` (Tambah library `dio`, `image_picker`, `provider`, `google_fonts`).
- [x] **F-02:** Implementasi Halaman Login & Registrasi (*UI Authentication Layer*).
- [x] **F-03:** Desain Halaman Dashboard Utama (Home) dengan susunan Grid Card Statistik 2x2 untuk metrik v7.
- [x] **F-04:** Pembuatan Workspace Intake Media (Fungsi buka Kamera HP dan Galeri Gambar menggunakan `image_picker`).
- [x] **F-05:** Mengintegrasikan HTTP Client `Dio` untuk melakukan upload multipart form-data (mengirim gambar dari HP ke server API online).

---

## 🟪 FASE 5: Agentic AI & Analytics Integration (HARI 3 — 14 Juni 2026)
*Target: Menyambungkan chat interaktif dengan Antigravity Consultant.*

- [x] **A-01:** Penulisan fungsi router `POST /api/v1/agent/consult` di backend (Integrasi API LLM taktis ringan).
- [x] **A-02:** Menanamkan aturan identitas dan instruksi ketat dari `AGENTS.md` ke dalam sistem prompt backend.
- [x] **A-03:** Membuat komponen widget *Overlay Chat / Sliding Sheet* Antigravity Consultant di Flutter.
- [x] **A-04:** Implementasi mekanisme penyimpanan riwayat log pengujian lokal (SQLite lokal) untuk menghitung total media yang sukses diuji oleh user.

---

## 🟥 FASE 6: Pengujian Sistem, Dokumen Sidang UAS & Submit (HARI 4 — 15 - 16 Juni 2026)
*Target: Mempersiapkan materi luaran dan melakukan pengumpulan.*

- [ ] **T-01:** Menjalankan pengujian akhir *End-to-End* (Mulai dari registrasi user, jepret foto wajah, kalkulasi model visi, hingga pembacaan teks obrolan AI Agent).
- [ ] **T-02:** Menyusun Dokumen Laporan Akhir Tugas Besar (PDF) dengan mengadaptasi file `Laporan_Deepfake_Detection_v2.docx`, lalu memperbarui isinya dengan grafik kurva training, ROC curve, dan matriks konfusi dari folder output v7.
- [ ] **T-03:** Mendesain Poster Ilmiah Ukuran A1 menggunakan template standar (Sematkan logo UNAND, screenshot UI aplikasi, diagram pipa v7, dan QR Code tautan backend).
- [ ] **T-04:** Merekam Video Demonstrasi Aplikasi berdurasi 5-10 menit (Presentasi fitur deteksi wajah asli dan palsu).
- [ ] **T-05:** Mengompresi berkas kode bersih Flutter dan FastAPI ke dalam format ZIP (`Source_Code_TugasBesar_NIM.zip`).
- [ ] **T-06:** Mengirimkan berkas atau link repositori ke email resmi dosen (`derisma@fti.unand.ac.id`) sebelum batas waktu 16 Juni 2026 pukul 23.59 WIB.
