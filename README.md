We are Using `llama3.1:latest` with Ollama, and includes all previous enhancements (🎥 video, icons, features, etc.).

---

````markdown
# 🚀 Flutter Chat App with vLLM + Ollama (`llama3.1:latest`)

A cross-platform 💬 **Chat Application** built with **Flutter**, integrating **Ollama** hosting the `llama3.1:latest` model via a Python backend.

---

## 🔧 Features

- 🧠 **LLM Chat** with `llama3.1:latest` via Ollama
- 📲 **Flutter UI** for Android/iOS/Web
- ⚙️ **Python FastAPI** backend
- 🔗 **REST API** integration
- 🎥 Video demo attached

---

## 📹 Demo Video

> ▶️ Watch the working demo here:
![Screen_recording_20250708_201728-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/af32d0d0-e70b-4ebc-a1ac-9d6d3d4a97c8)


---

## 📁 Project Structure

```bash
├── flutter_frontend/        # Flutter app UI
├── backend_server/          # Python FastAPI + Ollama API
│   ├── app.py               # API server logic
├── models/                  # Ollama local models
└── README.md
````

---

## 💻 Requirements

### ✅ Flutter Frontend

* Flutter SDK (>=3.10.0)
* Dart >= 3.0.0
* Dependencies:

  * `http`
  * `flutter_dotenv`
  * `provider` (optional)

### ✅ Python Backend

* Python 3.10+
* Dependencies:

  * `fastapi`, `uvicorn`
  * `ollama`
  * `langchain-ollama`

---

## ⚙️ Setup Guide

### 🧩 Step 1: Ollama Setup

1. 🔹 Run the model:

   ```bash
   ollama run llama3.1:latest
   ```

2. 🔹 Install Python packages:

   ```bash
   pip install fastapi uvicorn langchain-ollama pandas
   ```

3. 🔹 Start API Server:

   ```bash
   uvicorn app:app --host 0.0.0.0 --port 8000
   ```

---

### 📱 Step 2: Flutter Setup

1. Navigate to the Flutter project:

   ```bash
   cd flutter_frontend
   ```

2. Add a `.env` file:

   ```
   BASE_URL=http://<your-ip>:8000
   ```

3. Get packages and run:

   ```bash
   flutter pub get
   flutter run
   ```

---

## 🔄 Example API Request

```http
POST /v1/completions

{
  "model": "llama3.1:latest",
  "prompt": "Extract medcine data",
  "text":"The patient was prescribed Paracetamol 500 mg, to be taken twice daily after meals for mild fever. In addition, Amoxicillin 250 mg was recommended three times a day for 5 days to treat the underlying infection. For managing blood pressure, Amlodipine 5 mg was advised once every morning. To address gastric discomfort, the doctor added Pantoprazole 40 mg, to be taken once daily before breakfast. In case of severe pain, the patient may take Ibuprofen 400 mg, but not more than two tablets in 24 hours." 
}
```

---

## 👨‍💻 Developer

**Aravinth C**
🛠️ *Flutter and Data Science Developer*
🏢 *Software Engineer - Development*

---

## 🌟 To-Do

* 💾 Chat History Storage
* 🖼️ Text Extracting Integration

---

## 📜 License

MIT License © 2025 Aravinth C

---

```
```
