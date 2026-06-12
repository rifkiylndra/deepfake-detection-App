import os
import torch
from fastapi import FastAPI, UploadFile, File, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Optional
from datetime import datetime

# Import modular components
from app.model import XceptionFrozenBN
from app.utils import preprocess_image
from app.agent import get_antigravity_reply

# FastAPI application initialization
app = FastAPI(
    title="Deepfake Detection API & AI Agent Antigravity",
    description="Backend API supporting single-frame deepfake detection and forensic AI consultation",
    version="1.0.0"
)

# CORS Middleware setup
# Allows wildcard origins and methods to prevent network blocking from Flutter client
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Global variables for model and device
model = None
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
MODEL_PATH = os.path.join("weights", "model_final.pth")

@app.on_event("startup")
async def load_model():
    """Startup event: loads the XceptionFrozenBN model weights into memory."""
    global model
    print(f"[*] Starting up... Target device: {device}")
    
    # Initialize model architecture
    model = XceptionFrozenBN()
    
    if not os.path.exists(MODEL_PATH):
        print(f"[!] Warning: Model weights not found at {MODEL_PATH}.")
        print("[!] Running in dummy/uninitialized mode for weights. Please place the model weights file.")
        model.to(device)
        model.eval()
        return
        
    try:
        # Load weights
        print(f"[*] Loading model weights from {MODEL_PATH}...")
        state_dict = torch.load(MODEL_PATH, map_location=device, weights_only=True)
        model.load_state_dict(state_dict)
        model.to(device)
        model.eval()
        print("[+] Model loaded successfully and ready for inference.")
    except Exception as e:
        print(f"[x] Error loading model weights: {e}")
        raise RuntimeError(f"Could not load model weights: {e}")

@app.get("/health")
async def health_check():
    """Simple health check endpoint."""
    return {
        "status": "healthy",
        "device": str(device),
        "model_loaded": model is not None
    }

@app.post("/api/v1/detect")
async def detect_deepfake(file: UploadFile = File(...)):
    """Endpoint 1: Upload a single image, run inference, and return binary prediction with confidence score."""
    if model is None:
        raise HTTPException(status_code=503, detail="Model is not loaded on server.")
        
    # Validate file type
    if not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="Uploaded file must be an image.")
        
    try:
        # Read raw image bytes
        image_bytes = await file.read()
        
        # Preprocess image into tensor
        input_tensor = preprocess_image(image_bytes).to(device)
        
        # Inference
        with torch.no_grad():
            logits = model(input_tensor)
            probability = torch.sigmoid(logits).item()
            
        # Decision logic (threshold 0.5)
        # Class 0: REAL, Class 1: FAKE
        if probability >= 0.5:
            prediction = "FAKE"
            confidence_score = probability
        else:
            prediction = "REAL"
            confidence_score = 1.0 - probability
            
        return {
            "prediction": prediction,
            "confidence_score": round(confidence_score, 4)
        }
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Inference error: {str(e)}")

# Pydantic models for Agent Consult request and response schemas (section 04)
class MediaMetadata(BaseModel):
    filename: Optional[str] = "unknown.png"
    resolution: Optional[str] = "1080x1080"
    source: Optional[str] = "camera"

class InferenceResult(BaseModel):
    prediction: str
    confidence_score: float

class AgentConsultRequest(BaseModel):
    session_id: Optional[str] = "sess_default"
    media_metadata: Optional[MediaMetadata] = None
    inference_result: InferenceResult
    user_message: str

@app.post("/api/v1/agent/consult")
async def consult_antigravity(req: AgentConsultRequest):
    """Endpoint 2: Consult the Antigravity AI forensic agent about detection findings."""
    prediction = req.inference_result.prediction
    confidence_score = req.inference_result.confidence_score
    user_message = req.user_message
    
    # Get conversational reply from LLM agent
    agent_reply = await get_antigravity_reply(
        prediction=prediction,
        confidence_score=confidence_score,
        user_message=user_message
    )
    
    # Format properties based on standard forensic output templates
    confidence_percentage = f"{confidence_score * 100:.2f}%"
    
    if prediction == "FAKE":
        verdict = "REKAYASA_TERDETEKSI"
        forensic_analysis = "Ditemukan anomali distribusi spasial frekuensi tinggi pada batas penjahitan (blending) komponen wajah. Tekstur kulit kehilangan kontinutas natural."
        cyber_security_risk = "Tinggi. Berpotensi digunakan untuk taktik digital impersonation atau pemalsuan identitas (identity theft)."
    else:
        verdict = "ASLI"
        forensic_analysis = "Struktur anatomi wajah, bayangan alami di bawah dagu, serta refleksi cahaya pada permukaan wajah berada dalam batas distribusi frekuensi normal citra natural."
        cyber_security_risk = "Rendah. Tidak ditemukan indikasi manipulasi generatif kecerdasan buatan."
        
    return {
        "agent_name": "Antigravity",
        "timestamp": datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ"),
        "status": "success",
        "payload": {
            "verdict": verdict,
            "confidence_percentage": confidence_percentage,
            "forensic_analysis": forensic_analysis,
            "cyber_security_risk": cyber_security_risk,
            "agent_conversational_reply": agent_reply
        }
    }
