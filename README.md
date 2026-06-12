# Deepfake Forensic App

An integrated system featuring a Flutter Mobile/Desktop Application and a FastAPI Python backend designed to detect AI-manipulated facial images (Deepfakes) using a custom Xception-based Deep Learning model. The system also includes **Antigravity AI Agent**, a conversational forensic assistant that explains detection results in a clear, scientific, and human-readable manner.

## 🚀 Features
- **Deepfake Detection:** Utilizes a fine-tuned `XceptionFrozenBN` model to classify facial images as REAL or FAKE.
- **AI Forensic Consultant:** The Antigravity AI Agent breaks down complex computer vision probabilities into easy-to-understand forensic narratives.
- **Cross-Platform Interface:** Sleek frontend built with Flutter, adopting a modern "Dark Slate & Deep Teal" design system.
- **RESTful API:** Robust FastAPI backend handling inference pipelines and agent conversations via Context Injection.

## 📁 Repository Structure
- `backend_fastapi/`: Contains the FastAPI server, PyTorch model definitions, and Antigravity Agent logic.
- `frontend_flutter/`: Contains the Flutter UI application, State Management (Provider), and SQLite database helper.

## 🛠️ Technology Stack
- **Frontend:** Flutter, Dart, Provider, SQLite
- **Backend:** Python, FastAPI, PyTorch, Uvicorn, OpenAI API (for the LLM Agent)

## ⚙️ Getting Started

### Backend Setup
1. Navigate to the backend directory: `cd backend_fastapi`
2. Create and activate a virtual environment: `python -m venv venv`
3. Install dependencies (e.g., FastAPI, Uvicorn, PyTorch).
4. Start the server: `uvicorn app.main:app --host 127.0.0.1 --port 7860`

### Frontend Setup
1. Navigate to the frontend directory: `cd frontend_flutter`
2. Install packages: `flutter pub get`
3. Run the application: `flutter run`

## 🎓 Academic Context
Developed as a Final Project for the **Image Processing (DIF60202)** course.
- **Developer:** Rifki Yuliandra
- **Program Studi:** Informatika, Universitas Andalas
