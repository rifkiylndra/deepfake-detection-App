# Product Requirement Document (PRD)
## Aplikasi Mobile Deteksi Deepfake & AI Agent Antigravity

---

### Informasi Proyek
* **Nama Proyek:** Deepfake Detection Mobile App & AI Agent Antigravity
* **Mata Kuliah / Institusi:** DIF60202 — Image Processing | Informatika, Universitas Andalas
* **Pemilik Proyek (Author):** Rifki Yuliandra (Mahasiswa Semester 6)
* **Target Penyerahan:** 16 Juni 2026, pukul 23.59 WIB (Sisa Waktu: 4 Hari)
* **Status Dokumen:** Final Draft - Siap Eksekusi

---

### Fokus Utama Pengembangan (Blueprint Strategis)
1. **Scope Jelas:** Deteksi difokuskan pada analisis citra wajah tunggal (*single-frame face bounding box*) dengan resolusi input $299 \times 299$ piksel menggunakan arsitektur model v7 teroptimasi.
2. **Revisi Lebih Terkontrol:** Membatasi fitur tambahan agar tetap realistis dan dapat diselesaikan dalam jendela waktu kritis 4 hari tanpa mengurangi bobot penilaian.
3. **Timeline Aman:** Manajemen sprint harian taktis untuk mengamankan fungsionalitas penuh aplikasi dan mengklaim bonus nilai UAS sebesar +10%.

---

## 01. Project Overview
Aplikasi Mobile Deteksi Deepfake ini dikembangkan sebagai bentuk pemenuhan Tugas Besar Akhir (UAS) untuk mata kuliah Image Processing (DIF60202) di Universitas Andalas. Menjawab amanat motto tugas, yaitu *"Build an AI Product, not only an AI Model"*, proyek ini tidak hanya berhenti pada tahap eksperimen kecerdasan buatan di dalam Jupyter Notebook, melainkan mendistribusikan model Deep Learning kustom tersebut ke dalam produk perangkat lunak mobile yang siap pakai, interaktif, dan bernilai guna tinggi.

Sistem ini memadukan **Flutter Mobile App** sebagai antarmuka pengguna utama (frontend) dengan **AI Agent Antigravity** yang disematkan pada arsitektur server backend berbasis **FastAPI**. Aplikasi ini mendeteksi indikasi rekayasa digital/manipulasi wajah (*deepfake*) pada gambar dengan memanfaatkan model pembelajaran mendalam berbasis arsitektur **Xception** yang telah disempurnakan melalui teknik *Frozen BatchNorm Fine-Tuning* pada iterasi model v7, memastikan performa dan kemampuan generalisasi yang andal saat menguji berkas media baru.

---

## 02. Goals (Tujuan Proyek)
* **Fungsionalitas Penuh Produk AI:** Membangun aplikasi mobile berbasis Flutter yang lancar dalam mengunggah gambar (dari galeri maupun kamera gawai), melakukan inferensi deteksi secara *real-time* via REST API backend, dan menyajikan hasil analisis dengan representasi visual yang informatif.
* **Mengamankan Bonus Nilai Maksimal (+10%):** Memenuhi komponen penilaian tingkat lanjut dari rubrik UAS dengan mengimplementasikan model Deep Learning rancangan sendiri (v7), arsitektur aplikasi mobile Flutter, visualisasi analitik performa, serta manajemen database login pengguna (*User Auth*).
* **Interaktivitas Berbasis Agentic AI:** Menyediakan fitur inovasi berupa modul percakapan interaktif dengan AI Agent Antigravity untuk memberikan konsultasi siber, edukasi forensik citra, dan penjelasan kontekstual berbasis data probabilitas model kepada pengguna.

---

## 03. Features List (Daftar Fitur Utama)

### 1. Autentikasi & Manajemen Sesi Pengguna (Bonus Rubrik)
* Sistem registrasi dan login akun pengguna menggunakan token JWT (*JSON Web Token*) demi keamanan data.
* Menyimpan status login secara lokal (*persistent session state*) agar pengguna tidak perlu masuk berulang kali saat membuka aplikasi.

### 2. Pengambilan & Input Media Fleksibel
* **Galeri Perangkat:** Mengintegrasikan pustaka sistem untuk memilih berkas gambar berformat JPG/PNG yang tersimpan di dalam galeri handphone.
* **Kamera Langsung:** Mengaktifkan modul kamera perangkat untuk mengambil foto wajah secara langsung (*webcam/on-device camera capturing*).

### 3. Komputasi Inferensi Deteksi & Confidence Scoring
* Prapemrosesan otomatis pada sisi server (mengubah ukuran citra menjadi $299 \times 299$ px, ekstraksi matriks RGB, dan normalisasi sesuai statistik bobot ImageNet).
* Klasifikasi akhir biner yang tegas untuk menentukan status gambar (**REAL** atau **FAKE**) disertai tampilan *Confidence Score* dalam bentuk persentase probabilitas berbasis fungsi aktivasi Sigmoid.

### 4. Konsultasi Interaktif AI Agent Antigravity (Fitur Inovasi)
* Halaman obrolan (*Chat Interface*) khusus di dalam aplikasi untuk berkomunikasi dengan Agen Antigravity.
* Agen membaca status hasil uji media pengguna secara kontekstual dan menjabarkan analisis forensik citra dalam bahasa alami yang edukatif.

### 5. Dashboard Statistik & Analitik Ringkas
* Menampilkan metrik data pengujian lokal: jumlah total gambar yang telah diuji oleh pengguna.
* Menyajikan ringkasan performa model yang akurat berdasarkan uji klinis model v7 (Akurasi Global: **70.83%** | AUC: **0.7815**).
* Menampilkan pencatatan waktu inferensi (*latency*) rata-rata dalam satuan milidetik (ms).

---

## 04. User Flow (Alur Perjalanan Pengguna)
1. **Akses Masuk:** Pengguna membuka aplikasi $\rightarrow$ Melakukan pendaftaran/login di Halaman Autentikasi $\rightarrow$ Masuk ke Dashboard Utama aplikasi.
2. **Pemilihan Berkas:** Pengguna menekan tombol "Mulai Pengujian" $\rightarrow$ Memilih metode input ("Ambil Foto Kamera" atau "Pilih dari Galeri") $\rightarrow$ Aplikasi menampilkan gambar terpilih pada komponen *Image Preview Area*.
3. **Proses Inferensi:** Pengguna menekan tombol "Analisis Media" $\rightarrow$ Flutter mengirimkan berkas citra tersebut menggunakan metode HTTP Multipart POST menuju endpoint FastAPI $\rightarrow$ Model v7 mengevaluasi gambar.
4. **Penyajian Output:** Flutter menerima kembalian data berupa respons JSON $\rightarrow$ Mengubah tampilan UI secara dinamis dengan warna indikator yang kontras (Merah untuk FAKE, Hijau untuk REAL) beserta skor keyakinan model.
5. **Aktivasi Agen:** Pengguna menekan tombol "Konsultasi Forensik Antigravity" $\rightarrow$ Sistem membuka overlay chat $\rightarrow$ AI Agent memberikan penjelasan naratif terkait hasil deteksi dan memberikan anjuran keamanan digital.

---

## 05. Functional Requirements (Kebutuhan Fungsional Sistem)

| ID | Nama Fungsi | Deskripsi Kebutuhan Teknis | Tingkat Prioritas |
| :--- | :--- | :--- | :---: |
| **FR-01** | Otentikasi User | Sistem harus mampu memvalidasi data login, menerbitkan token akses, dan mengamankan rute halaman dalam aplikasi. | Medium |
| **FR-02** | Media Acquisition | Aplikasi wajib mendeteksi perangkat kamera dan direktori penyimpanan gambar eksternal dengan izin (*permission*) pengguna. | High |
| **FR-03** | REST API Inference | Server backend harus menyediakan endpoint tangguh `/api/v1/detect` yang menerima berkas gambar dan mengembalikan klasifikasi serta *confidence score*. | High |
| **FR-04** | Agent Dialogue Layer | Modul chat backend harus mampu menyerap status probabilitas model v7 dan merumuskannya ke dalam prompt agen LLM untuk dibaca pengguna. | High |
| **FR-05** | Local Logging | Aplikasi harus menyimpan riwayat log pengujian lokal (waktu uji, nama berkas, status hasil) ke dalam database ringan. | Medium |

---

## 06. Technical Stack (Komponen Teknologi)
* **Frontend Mobile Application:** **Flutter (Dart)** – Digunakan untuk merancang antarmuka pengguna yang dinamis, manajemen *state* aplikasi, pemrosesan kamera lokal, serta penanganan komunikasi data HTTP Client.
* **Backend API Gateway:** **FastAPI (Python)** – Dipilih karena memiliki performa tinggi (*high-performance*), dukungan asinkronus penuh, dan integrasi yang mulus dengan pustaka data science Python.
* **Deep Learning Engine:** **PyTorch 2.6.0 & Timm Library** – Digunakan untuk memuat arsitektur *Xception dengan Frozen BatchNorm Fine-Tuning* menggunakan berkas bobot terbaik dari iterasi eksperimen v7 (`model_final.pth` berukuran ~84 MB).
* **AI Agent Architecture:** **Antigravity Framework Layer** – Pipa pemrosesan prompt terstruktur (*structured prompt engineering pipeline*) yang mengonversi skor biner visi komputer menjadi teks narasi edukasi keamanan siber.
* **Database & Sesi:** **SQLite / Supabase** – Sebagai media penyimpanan terstruktur untuk data tabel user, kredensial password, dan catatan riwayat pengujian gambar.
* **Deployment & Infrastruktur:** **Docker Container & Hugging Face Spaces / Render** – Digunakan untuk melakukan kompilasi lingkungan backend ke dalam kontainer terisolasi dan men-deploy secara online agar dapat diakses oleh aplikasi Flutter.

---

## 07. Timeline & Rencana Kerja Sprint (Sisa Jendela Waktu 4 Hari)

### Hari 1: Backend Development & Model Deployment (12 Juni 2026)
* **Fokus Kerja:** Konfigurasi dasar server FastAPI, penulisan fungsi prapemrosesan matriks gambar ($299 \times 299$ px, normalisasi ImageNet), pemuatan berkas model v7 (`model_final.pth`).
* **Output Nyata:** Endpoint lokal `/api/v1/detect` berhasil diuji menggunakan Postman, pembungkusan berkas ke dalam Dockerfile, dan inisiasi *deployment* online ke Hugging Face Spaces.

### Hari 2: Frontend UI Mobile & API Integration (13 Juni 2026)
* **Fokus Kerja:** Inisialisasi proyek Flutter, pembuatan arsitektur folder, penyusunan Halaman Utama (Dashboard), Halaman Deteksi, halaman pratinjau gambar, serta integrasi pustaka `image_picker`.
* **Output Nyata:** Aplikasi mobile mampu menangkap gambar dari kamera HP dan mengirimkannya via HTTP Client POST ke server API online serta menampilkan hasil klasifikasi (REAL/FAKE) pada layar.

### Hari 3: AI Agent Integration & Dashboard Analytics (14 Juni 2026)
* **Fokus Kerja:** Pengembangan modul obrolan *Antigravity Agent Layer* di backend, penyusunan antarmuka chat di Flutter, pembuatan komponen grafik statistik lokal, dan penyelesaian fitur login/registrasi user.
* **Output Nyata:** Pengguna dapat berinteraksi langsung dengan AI Agent pasca-deteksi gambar, dan halaman statistik menampilkan visualisasi metrik jumlah pengujian serta rata-rata *latency* sistem secara akurat.

### Hari 4: System Testing, Documentation & Submission (15 - 16 Juni 2026)
* **Fokus Kerja:** Pengujian menyeluruh (*end-to-end testing*) untuk meminimalkan *bug*, penyusunan dokumen Laporan Akhir PDF berdasarkan hasil v7, pembuatan desain Poster Ilmiah A1, perekaman video demonstrasi aplikasi (durasi 5-10 menit).
* **Output Nyata:** Seluruh berkas source code dikompresi (ZIP), poster dicetak/dieksport ke PDF, video diunggah, dan tugas besar dikirimkan ke email resmi dosen sebelum batas waktu 16 Juni 2026 pukul 23.59 WIB.

---

## 08. Scope & Deliverables (Cakupan & Luaran Akhir)

### Di Dalam Cakupan (In-Scope):
1. Deteksi keaslian manipulasi visual berfokus pada area wajah tunggal manusia.
2. Komunikasi data yang aman dan cepat antara Flutter mobile dan FastAPI menggunakan protokol HTTP REST dan format data JSON.
3. Dashboard metrik analitik menyajikan akumulasi pengujian riil yang tercatat pada basis data lokal pengguna aktif.

### Di Luar Cakupan (Out-of-Scope):
1. Deteksi manipulasi kloning suara (*deepfake audio processing*).
2. Pemrosesan file video berdurasi panjang secara langsung di dalam memori internal handphone tanpa koneksi internet server (*on-device live video stream inference*).

### Berkas Luaran yang Dikumpulkan (Final Deliverables):
1. **Source Code Proyek (ZIP):** Berkas kode bersih komponen Flutter dan backend FastAPI.
2. **Laporan Akhir (PDF):** Dokumen ilmiah komprehensif susunan 5 BAB yang memuat hasil pengujian performa model v7 dan dokumentasi rekayasa aplikasi.
3. **Poster Ilmiah (Ukuran A1):** Memuat judul riset, diagram arsitektur sistem, tangkapan layar aplikasi mobile, grafik hasil evaluasi model v7, serta QR Code.
4. **Video Demo Sistem:** Rekaman presentasi operasional produk aplikasi berdurasi 5-10 menit.
5. **Link Deployment Online:** Tautan URL server backend aktif yang siap diuji kapan saja oleh dosen penilai.
