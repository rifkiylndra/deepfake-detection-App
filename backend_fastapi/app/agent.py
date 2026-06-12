import os
from openai import AsyncOpenAI

# Initialize AsyncOpenAI client
# It will automatically pick up the OPENAI_API_KEY from environment variables.
# If the key is not present or invalid, errors will be caught gracefully in the function call.
client = None

def get_openai_client():
    global client
    if client is None:
        api_key = os.environ.get("OPENAI_API_KEY")
        if api_key:
            client = AsyncOpenAI(api_key=api_key)
        else:
            # Fallback client instantiation (will fail if invoked without key, unless mock/override)
            client = AsyncOpenAI(api_key="mock_key_if_not_present")
    return client

async def get_antigravity_reply(prediction: str, confidence_score: float, user_message: str) -> str:
    """Invokes the Antigravity AI forensic & cybersecurity agent.

    Uses Context Injection to merge classification results into the system prompt.
    """
    confidence_percentage = f"{confidence_score * 100:.2f}%"
    
    # 1. Dynamic System Instructions to lock persona and context
    system_instruction = (
        "Anda adalah Antigravity, AI Agent Forensik Citra & Konsultan Keamanan Siber Interaktif.\n\n"
        "PERAN UTAMA:\n"
        "Tugas Anda adalah menerjemahkan dan menganalisis hasil deteksi deepfake secara ilmiah, "
        "objektif, edukatif, serta mudah dipahami oleh orang awam. Anda adalah konsultan keamanan digital.\n\n"
        "KONTEKS HASIL DETEKSI (SUNTIKAN KONTEKS):\n"
        f"- Hasil inferensi model v7: Citra terdeteksi sebagai {prediction}.\n"
        f"- Tingkat keyakinan (Confidence Score): {confidence_percentage}.\n\n"
        "PANDUAN PERILAKU & ATURAN:\n"
        "1. Gunakan Bahasa Indonesia yang formal, sopan, dan profesional.\n"
        "2. Berikan analisis forensik citra dari sudut pandang visual (seperti inkonsistensi bayangan, "
        "tekstur kulit yang tidak wajar, distorsi pada batas wajah, arah pencahayaan pupil mata, dll).\n"
        "3. Berikan edukasi tentang risiko keamanan siber (misalnya pencurian identitas, impersonasi digital, penipuan online).\n"
        "4. Berikan rekomendasi praktis keamanan siber untuk melindungi privasi atau data digital pengguna.\n"
        "5. DILARANG KERAS menggunakan istilah teknis internal pemrograman/PyTorch/library/kode (seperti: "
        "num_workers, GradScaler, timm, epoch, optimizer, learning rate, loss function, logits, activation, "
        "sigmoid, model_final.pth, batch_size, model.py, utils.py, main.py, dataset FF++, atau Celeb-DF) dalam jawaban Anda.\n"
        "6. Jaga nada bicara tetap analitis, cerdas, waspada, dan mengayomi."
    )
    
    # Check if a valid API key is present
    api_key = os.environ.get("OPENAI_API_KEY")
    if not api_key:
        # Graceful degradation fallback if API key is missing
        if prediction == "FAKE":
            return (
                f"Halo, saya Antigravity. Analisis sistem kami menunjukkan tingkat manipulasi digital "
                f"sebesar {confidence_percentage}. Pada citra 'FAKE', anomali visual sering terjadi pada transisi batas wajah "
                f"dan tekstur kulit yang tidak alami. Untuk keamanan siber Anda, sangat disarankan untuk tidak "
                f"menggunakan berkas citra ini sebagai dokumen resmi atau identitas administrasi online guna menghindari "
                f"risiko impersonasi identitas digital."
            )
        else:
            return (
                f"Halo, saya Antigravity. Berdasarkan pemindaian kami, citra ini tergolong REAL dengan tingkat keyakinan "
                f"sebesar {confidence_percentage}. Secara visual, struktur geometri wajah dan pencahayaan berada dalam batas normal "
                f"citra alami. Namun, mohon tetap waspada terhadap potensi penyalahgunaan profil foto asli oleh oknum tidak bertanggung jawab. "
                f"Selalu lakukan verifikasi sekunder dalam interaksi digital Anda."
            )

    try:
        openai_client = get_openai_client()
        response = await openai_client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[
                {"role": "system", "content": system_instruction},
                {"role": "user", "content": user_message}
            ],
            temperature=0.3
        )
        return response.choices[0].message.content
    except Exception as e:
        # Fallback response in case of API request failures
        return (
            f"[Koneksi Antigravity Terganggu] Hasil analisis forensik citra mendeteksi: {prediction} "
            f"({confidence_percentage}). Mohon pastikan keaslian gambar sebelum menggunakannya dalam transaksi digital."
        )
