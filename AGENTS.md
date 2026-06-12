# Spesifikasi dan Arsitektur AI Agent — Antigravity

**Mata Kuliah:** DIF60202 — Image Processing  
**Program Studi:** Informatika, Universitas Andalas  
**Pengembang:** Rifki Yuliandra  
**Konteks Tugas:** Komponen Inovasi & Kreativitas (+10% Bonus Rubrik UAS)  
**Dokumen Pendamping:** `PRD_Deepfake_Detection_Mobile_App.md`

---

## 01. Deskripsi Umum
**AI Agent Antigravity** adalah komponen kecerdasan buatan berbasis *Natural Language Processing* (NLP) yang diintegrasikan ke dalam ekosistem backend FastAPI dan diakses melalui antarmuka obrolan (*chat interface*) pada aplikasi Flutter Mobile. 

Agen ini bertindak sebagai **Interactive Cyber Security & Forensic Consultant**. Peran utamanya adalah mentransformasikan luaran mentah komputer visi (*raw computer vision outputs*)—yang berupa klasifikasi biner (**REAL/FAKE**) dan *confidence score* dari **Model Deep Learning v7 (Xception + Frozen BN)**—menjadi narasi analisis forensik citra yang komprehensif, edukatif, berbobot ilmiah, serta mudah dipahami oleh pengguna awam.

---

## 02. Arsitektur Integrasi Sistem & Aliran Data
Antigravity Agent tidak bekerja secara terisolasi. Agen ini memanfaatkan teknik *Context Injection* (Suntikan Konteks) yang dinamis, di mana status internal (*state*) dari pipa inferensi citra langsung diumpankan ke dalam memori jangka pendek agen sebelum memberikan respons kepada pengguna.

### Diagram Aliran Data Forensik:
1. **Media Upload:** Pengguna mengunggah atau mengambil gambar wajah melalui Flutter Mobile.
2. **Inference Pipeline:** Backend FastAPI menerima gambar, menjalankan prapemrosesan ($299 \\times 299$ px, normalisasi ImageNet), dan mengevaluasi menggunakan model v7 (`model_final.pth`).
3. **Metrics Extraction:** Hasil fungsi aktivasi Sigmoid menghasilkan probabilitas nilai $P(\\text{Fake})$ dan label keputusan akhir (Threshold = 0.5).
4. **Agent Context Injection:** Nilai probabilitas, keputusan biner, beserta metadata gambar dijahit ke dalam *System Prompt* Agen Antigravity.
5. **Response Generation:** Agen merumuskan respons kontekstual dan mengirimkannya kembali ke Flutter dalam format JSON terstruktur.

---

## 03. Rekayasa Prompt Sistem (System Prompt Engineering Blueprint)

Berikut adalah instruksi dasar (*System Prompt*) absolut yang ditanamkan pada server backend untuk mengunci persona dan membatasi perilaku AI Agent Antigravity:

## 04. Skema Integrasi API & Kontrak Payload JSON
Komunikasi data asinkronus antara komponen antarmuka Flutter (Chat Widget) dan Antigravity Agent Layer di FastAPI diatur melalui kontrak payload REST API berikut:

**Endpoint:** `POST /api/v1/agent/consult`

### 1. Request Header
```http
Content-Type: application/json
Authorization: Bearer <JWT_TOKEN_PENGGUNA>
```

### 2. Request Body (Dari Flutter ke FastAPI)
```json
{
  "session_id": "sess_20260612_009",
  "media_metadata": {
    "filename": "wajah_uji_01.png",
    "resolution": "1080x1080",
    "source": "camera"
  },
  "inference_result": {
    "prediction": "FAKE",
    "confidence_score": 0.7815
  },
  "user_message": "Apakah foto ini aman jika saya jadikan lampiran bukti administrasi online?"
}
### 3. Response Body (Dari FastAPI kembali ke Flutter)
```json
{
  "agent_name": "Antigravity",
  "timestamp": "2026-06-12T09:27:00Z",
  "status": "success",
  "payload": {
    "verdict": "REKAYASA_TERDETEKSI",
    "confidence_percentage": "78.15%",
    "forensic_analysis": "Ditemukan anomali distribusi spasial frekuensi tinggi pada batas penjahitan (blending) komponen wajah. Tekstur kulit kehilangan kontinutas natural.",
    "cyber_security_risk": "Tinggi. Berpotensi digunakan untuk taktik digital impersonation atau pemalsuan identitas (identity theft).",
    "agent_conversational_reply": "Halo. Saya Antigravity, konsultan forensik digital Anda. Berdasarkan pemrosesan citra wajah oleh mesin Xception v7 kami, gambar 'wajah_uji_01.png' yang Anda ambil lewat kamera terindikasi kuat merupakan produk manipulasi AI (Deepfake) dengan tingkat keyakinan sebesar 78.15%. Algoritma deteksi kami menangkap adanya distorsi pada area transisi antara wajah dan latar belakang, yang merupakan jejak umum manipulasi generatif. Demi keamanan digital Anda, sangat disarankan untuk tidak menggunakan atau mempercayai berkas citra ini sebagai dokumen valid."
  }
}
```

---

## 05. Skenario Operasional & Contoh Dialog (Mock Dialogues)
Berikut adalah cetak biru percakapan untuk memastikan konsistensi output teks dari Agen Antigravity saat dilakukan pengujian sistem (system testing):

### Skenario A: Citra Terindikasi Hasil Rekayasa (FAKE)
Pengguna: "Aplikasi bilang foto ini palsu. Bisakah kamu jelaskan bagian mana yang aneh?"

AI Agent Antigravity: "Tentu. Berdasarkan analisis forensik digital yang saya lakukan terhadap suntikan data model v7, gambar ini memiliki skor probabilitas manipulasi sebesar 78.15%. Pada tingkat teknis citra, algoritma deepfake generatif biasanya mengalami kesulitan dalam menyelaraskan arah datangnya cahaya (pencahayaan global) pada pupil mata kiri dan kanan secara simetris. Selain itu, tekstur kulit di area sekitar hidung tampak terlalu halus kehilangan noise alami (pori-pori). Jejak-jejak inkonsistensi spasial inilah yang membuat sistem kami mengategorikannya sebagai FAKE. Harap waspada, berkas ini memiliki risiko disinformasi yang tinggi."

### Skenario B: Citra Terindikasi Asli (REAL)
**Pengguna:** "Apakah foto profil ini asli? Saya takut ditipu oleh akun kloningan."

**AI Agent Antigravity:** "Hasil pemindaian visi komputer kami menunjukkan tingkat keaslian geometri sebesar 70.83%, yang berarti gambar ini diklasifikasikan sebagai REAL. Struktur anatomi wajah, bayangan alami di bawah dagu, serta refleksi cahaya pada permukaan wajah berada dalam batas distribusi frekuensi normal citra natural. Walau demikian, sebuah akun palsu tetap bisa menggunakan foto orang asli untuk menipu. Selalu lakukan verifikasi sekunder melalui saluran komunikasi lain untuk memastikan profil di balik akun tersebut benar-benar rekan Anda."

---

## 06. Rencana Implementasi Kode Backend (Fase FastAPI)
Untuk mewujudkan agen ini di FastAPI pada Hari 3 Sprint, potongan arsitektur kode Python yang akan kita implementasikan adalah sebagai berikut:

```python
from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
import openai  # Atau LLM Provider API lainnya

class AgentConsultRequest(BaseModel):
    prediction: str
    confidence_score: float
    user_message: str

@app.post("/api/v1/agent/consult")
async def consult_antigravity(req: AgentConsultRequest, user=Depends(get_current_user)):
    # 1. Konstruksi prompt dinamis dengan teknik Context Injection
    system_instruction = (
        "Anda adalah Antigravity, AI Agent Forensik Citra. "
        "Bantu pengguna menganalisis hasil deteksi deepfake berikut secara ilmiah. "
        f"Hasil Model: {req.prediction}, Confidence: {req.confidence_score:.4f}."
    )
    
    try:
        # 2. Call LLM API Engine (Misal menggunakan OpenAI/HuggingFace API)
        response = await openai.ChatCompletion.acreate(
            model="gpt-4o-mini",  # Atas basis agen taktis ringan
            messages=[
                {"role": "system", "content": system_instruction},
                {"role": "user", "content": req.user_message}
            ],
            temperature=0.3  # Menjaga suhu kreativitas agar tetap objektif/kaku
        )
        
        agent_reply = response.choices[0].message.content
        return {
            "agent_name": "Antigravity",
            "status": "success",
            "reply": agent_reply
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
```

---
*Dokumen ini merupakan hak kekayaan intelektual pengerjaan Tugas Besar UAS DIF60202 Informatika UNAND 2026.*