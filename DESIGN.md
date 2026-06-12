# Panduan Desain Antarmuka (DESIGN.md)
## Aplikasi Mobile Deteksi Deepfake & AI Agent Antigravity

Dokumen ini disusun sebagai spesifikasi teknis cetak biru (blueprint) UI/UX sekaligus **Prompt Kit** untuk digunakan pada **stitch.ai** dan diimplementasikan ke dalam **Flutter Mobile App**. Desain ini dirancang secara taktis untuk mengamankan seluruh kriteria penilaian UAS Image Processing (DIF60202) Universitas Andalas, termasuk komponen bonus inovasi (+10%).

---

## 01. Sistem Desain & Token Visual (Design Tokens)

Untuk membangun citra aplikasi forensik siber yang aman, profesional, terpercaya, dan canggih, seluruh elemen visual wajib mematuhi aturan token berikut:

### A. Palet Warna (Color Palette)
| Token Nama | Kode Hex | Implementasi Elemen | Vibe / Filosofi |
| :--- | :--- | :--- | :--- |
| **Primary (Dark Slate)** | `#0F172A` | Background Header, Teks Judul, Tombol Utama | Keamanan, Stabilitas, Profesionalitas |
| **Secondary (Deep Teal)** | `#0F766E` | Tombol Aksi, Batas Fokus, Accent Icon | Forensik Teknologi, Modernitas |
| **Background Light** | `#F8FAFC` | Latar Belakang Seluruh Halaman Utama | Bersih, Ringan, Kontras Tinggi |
| **Surface White** | `#FFFFFF` | Latar Belakang Card, Dialog, Input Field | Elegan, Struktur Rapi |
| **Alert / Fake (Red)** | `#EF4444` | Status Baju FAKE, Progress Bar Bahaya | Peringatan Kritis, Ancaman Siber |
| **Safe / Real (Green)** | `#10B981` | Status Baju REAL, Progress Bar Aman | Otentik, Valid, Terverifikasi |
| **Muted Text** | `#64748B` | Subtitle, Deskripsi Fitur, Waktu Log | Netral, Menurunkan Distraksi Visual |

### B. Tipografi (Typography Scale)
* **Font Family:** `Inter` atau `Roboto` (San-Serif kaku, bersih, modern)
* **Heading 1 (H1 - Title Halaman):** 22pt | Bold | Warna `#0F172A`
* **Heading 2 (H2 - Section Title):** 16pt | Semi-Bold | Warna `#0F172A`
* **Body Text (Informasi/Narasi):** 12pt | Regular | Warna `#334155`
* **Caption / Small (Log/Metadata):** 10pt | Regular | Warna `#64748B`

### C. Geometri & Elevasi (Geometry & Elevation)
* **Card Border Radius:** `12px` (Memberikan kesan modern tapi tidak terlalu bulat)
* **Button Border Radius:** `8px` (Tegas dan presisi)
* **Input Field Radius:** `8px`
* **Card Shadow:** `BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 4))` (Tipis, bersih, tidak kotor)

---

## 02. Arsitektur Cetak Biru Halaman (Screen Wireframes)

### Halaman 1: Welcoming & Autentikasi (Login Screen)
* **Fungsi:** Mengunci bonus nilai UAS untuk komponen *User Login*.
* **Struktur Komponen (Atas ke Bawah):**
    1.  *Spacer* top margin (30px).
    2.  **Logo Icon:** Ilustrasi perisai digital terintegrasi lensa kamera (`Icon(Icons.security_fused_with_camera)`).
    3.  **Judul Utama:** "Deepfake Forensic" (H1, Bold, `#0F172A`).
    4.  **Sub-Judul:** "Sistem Deteksi Manipulasi Wajah Universitas Andalas" (Caption, `#64748B`).
    5.  *Spacer* (40px).
    6.  **Input Field 1 (Email):** Lapisan border tipis abu-abu, ikon amplop di sebelah kiri, placeholder "Masukkan email mahasiswa".
    7.  **Input Field 2 (Password):** Lapisan border tipis abu-abu, ikon gembok di kiri, ikon mata di kanan (*toggle obscure text*), placeholder "Masukkan password".
    8.  *Spacer* (24px).
    9.  **Tombol Login:** Lebar penuh (*Full-width Button*), warna latar Deep Teal (`#0F766E`), teks putih "Masuk ke Sistem Keamanan".
    10. **Teks Registrasi:** Teks di tengah-tengah: "Belum punya akun? Daftar Sekarang" (Warna Teal, klik-aktif).

---

### Halaman 2: Dashboard & Analitik Ringkas (Home Screen)
* **Fungsi:** Menampilkan status akun dan statistik performa riil model v7.
* **Struktur Komponen (Atas ke Bawah):**
    1.  **Header Profile Bar (Row Layout):** Teks "Halo, Rifki Yuliandra" (H2) + Subtitle "Informatika UNAND" di sisi kiri, dan Ikon Profil Akun bundar di sisi kanan.
    2.  *Spacer* (20px).
    3.  **Hero Action Card (Banner Besar):** Warna latar `#0F172A`, di dalamnya terdapat:
        * Teks putih "Deteksi Gambar Sekarang".
        * Deskripsi pendek "Pindai citra wajah untuk menganalisis keaslian fitur spasial".
        * **Tombol Pindai:** Berwarna Emerald Green (`#10B981`), teks hitam/putih "Mulai Pindai Modul".
    4.  *Spacer* (24px).
    5.  **Section Title:** "Statistik Model Engine v7" (H2, `#0F172A`).
    6.  **Grid Analytics Overview (2x2 Grid Layout):**
        * *Card 1 (Total Diuji):* Ikon grafik naik | Nilai angka dinamis | Label "Total Citra Diuji".
        * *Card 2 (Akurasi):* Ikon centang hijau | Nilai **70.83%** | Label "Akurasi Global Uji FF++".
        * *Card 3 (AUC Core):* Ikon medali emas | Nilai **0.7815** | Label "Area Under Curve (AUC)".
        * *Card 4 (Latency):* Ikon stopwatch | Nilai dinamis (e.g., "142 ms") | Label "Rata-rata Waktu Inferensi".

---

### Halaman 3: Workspace Intake Media (Scan Screen)
* **Fungsi:** Tempat mengunggah, membidik, dan mempersiapkan citra wajah sebelum API call.
* **Struktur Komponen (Atas ke Bawah):**
    1.  **Top Navigation Bar:** Tombol Back panah kiri + Judul Halaman "Workspace Analisis" (H2).
    2.  *Spacer* (16px).
    3.  **Image Upload Workspace Card (Dashed Border Placeholder):**
        * *Kondisi Kosong:* Area kotak besar abu-abu terang dengan garis putus-putus (*dashed border*), di tengahnya ada ikon awan unggah (*cloud upload*) besar + teks "Belum ada citra dipilih. Format JPG/PNG maksimal 5MB".
        * *Kondisi Terisi:* Menampilkan gambar wajah pengguna secara penuh, proporsional (*fit: BoxFit.cover*), dengan sudut tumpul `radius 12px`.
    4.  *Spacer* (24px).
    5.  **Media Selector Row (Dua Tombol Berdampingan):**
        * *Tombol Kiri:* Warna latar putih, border Teal, ikon kamera, teks Teal "Ambil Kamera".
        * *Tombol Kanan:* Warna latar putih, border Teal, ikon galeri gambar, teks Teal "Buka Galeri".
    6.  *Spacer* (30px).
    7.  **Action Button Utama:** Tombol lebar penuh, warna **Primary Dark Slate (`#0F172A`)**, teks putih bold **"JALANKAN ANALISIS FORENSIK"**. (Tombol dinonaktifkan/disabled jika gambar belum dipilih untuk mencegah error 400).

---

### Halaman 4: Hasil Forensik & Chat AI Agent (Result & Consultation Screen)
* **Fungsi:** Komponen integrasi terpenting yang menyatukan visi komputer (v7) dan pemrosesan bahasa alami (Agent Antigravity).
* **Struktur Komponen (Atas ke Bawah):**
    1.  **Top Bar:** Judul "Laporan Forensik Citra" + Ikon Share di pojok kanan.
    2.  **Mini Image Preview:** Gambar wajah yang diuji diposisikan di tengah berukuran sedang, diberi bingkai tipis berwarna abu-abu.
    3.  **Verdict Badge (Status Utama):**
        * *Jika FAKE:* Banner merah penuh (`#EF4444`), teks putih tebal: **"TERINDIKASI FAKE / MANIPULASI"**.
        * *Jika REAL:* Banner hijau penuh (`#10B981`), teks putih tebal: **"TERVERIFIKASI REAL / ASLI"**.
    4.  **Confidence Score Bar:** Teks "Tingkat Keyakinan Model: 78.15%" + Linear Progress Bar (Jika FAKE warnanya Merah, Jika REAL warnanya Hijau).
    5.  *Spacer Line Divider* (Garis tipis abu-abu pembatas halaman).
    6.  **AI Agent Antigravity Layer (Sliding Sheet / Bottom Section):**
        * *Header Agen:* Baris berisi Ikon Avatar Robot Agent (`#0F766E`) + Nama Agen "Antigravity Consultant" + Status Badge "Online / Aktif".
        * *Chat Bubble Area:* Balon teks dari Agen Antigravity yang memuat narasi sesuai isi dokumen `AGENTS.md` (Analisis anomali spasial, bayangan mata, saran keamanan siber). Teks ditulis menggunakan background abu-abu sangat muda `#F1F5F9`.
        * *User Chat Input Field (Sticky Bottom):* Kotak input teks kecil di paling bawah bertuliskan "Tanyakan detail forensik pada Antigravity..." + Tombol ikon kirim (*send icon*) di sebelah kanan.

---

## 03. Kit Prompt untuk stitch.ai (Stitch.ai Prompting Blueprints)

Kamu bisa menyalin (*copy-paste*) prompt teks terstruktur di bawah ini langsung ke dalam kolom generator UI **stitch.ai** untuk menghasilkan tata letak komponen secara kilat:

### Prompt 1: Untuk Halaman Login
> `"Create a clean, professional mobile login screen for a Cyber Security app. Background is #F8FAFC. Top section has a sleek security shield icon and a bold title 'Deepfake Forensic' in #0F172A. Middle section contains two modern rounded input fields for Email and Password with prefix icons. Bottom section has a full-width solid elevated button in deep teal color #0F766E with white text 'Masuk ke Sistem Keamanan'. Below the button, add a centered text link 'Belum punya akun? Daftar Sekarang' in teal color."`

### Prompt 2: Untuk Halaman Dashboard Utama
> `"Design a mobile home screen dashboard for an AI analytics application. Top bar features a user greeting 'Halo, Rifki Yuliandra' and a circular avatar profile. Main section features a prominent dark card (#0F172A) acting as a hero section with text 'Deteksi Gambar Sekarang' and an emerald green action button (#10B981). Below the hero card, create a 2x2 grid layout of statistic cards. Each card has a subtle shadow, a clean icon, large bold numeric values, and soft gray labels for: Total Citra Diuji, Akurasi Global (70.83%), Area Under Curve (0.7815), and Latency (142 ms). Total background color is #F8FAFC."`

### Prompt 3: Untuk Halaman Workspace Upload
> `"Create a mobile upload and scan view screen. Top navigation has a back arrow and title 'Workspace Analisis'. The center of the screen is dominated by a large card with a dashed border placeholder, showing a cloud upload icon and instruction text 'Belum ada citra dipilih'. Below the image card, there are two equal-width secondary buttons side-by-side: 'Ambil Kamera' and 'Buka Galeri', both stylized with deep teal outlines and icons. At the very bottom, add a fixed full-width primary button in dark slate color #0F172A with bold white text 'JALANKAN ANALISIS FORENSIK'."`

### Prompt 4: Untuk Halaman Hasil & Chat Agen AI
> `"Design a mobile forensic result split-screen interface. Top half displays a centered tested face image with a prominent large warning banner below it. The banner is solid red (#EF4444) for 'TERINDIKASI FAKE / MANIPULASI' with a horizontal progress bar showing 78.15% confidence. The bottom half transitions smoothly into an interactive AI Agent Chat window. The chat header has a green active status dot and label 'Antigravity Consultant'. Inside the chat area, display an elegant gray chat bubble with a detailed narrative analysis text. The bottom of the screen has a sticky text input field with a send icon for user consultation."`

---

## 04. Manajemen Status UI (UI State Management Lifecycle)

Untuk menjamin aplikasi mobile tidak kaku (*freeze*) saat melakukan proses pengiriman file gambar ke server backend FastAPI, kodingan Dart Flutter harus merepresentasikan 3 status siklus hidup visual berikut:

### 1. Status Memuat (Loading / Inference State)
* **Visual UI:** Ketika tombol "JALANKAN ANALISIS FORENSIK" ditekan, ubah tombol menjadi status memuat (*disabled loading state*) dengan menampilkan komponen `CircularProgressIndicator` kecil di tengah tombol.
* **Skeleton View:** Area *Verdict Badge* dan *Chat Bubble* di halaman hasil digantikan oleh komponen **Shimmer Effect** (efek kotak abu-abu bergelombang/animasi memudar) untuk memberi tahu pengguna bahwa data sedang diproses oleh model PyTorch v7 di server.

### 2. Status Gagal (Error / Fail State)
* **Kondisi Pemicu:** Koneksi internet terputus, server FastAPI mati (*timeout*), atau file yang dikirim rusak.
* **Visual UI:** Tampilkan halaman/dialog *overlay modal* yang bersih dengan warna aksen merah lembut, memuat ikon `Icons.wifi_off` atau `Icons.error_outline`. Tampilkan pesan teks informatif: "Gagal terhubung ke Server Deteksi UNAND" lengkap dengan tombol aksi ulang **"Coba Lagi"**.

### 3. Status Sukses (Success State)
* **Visual UI:** Menghentikan seluruh animasi memuat, memicu efek transisi memudar masuk (*fade-in animation*), lalu merendah-masukkan komponen hasil deteksi riil bersama dengan teks respons konsultasi dari AI Agent Antigravity secara instan dan rapi.
