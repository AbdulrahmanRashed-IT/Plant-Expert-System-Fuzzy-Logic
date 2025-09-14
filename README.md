# 🌱 Plant Expert System (Fuzzy Logic)

This project is an **Expert System for Plant Pest & Disease Diagnosis** using **Fuzzy Logic**.  
It helps farmers and researchers identify pests/diseases based on symptoms, analyze severity, and provide control solutions.

---

## 🚀 Features
- Diagnose plant pests/diseases using **fuzzy inference rules**.
- Database of:
  - **Hama (Pests)**
  - **Penyakit (Diseases)** (via `penyakit` view)
  - **Gejala (Symptoms)**
  - **Fuzzy Rules**
  - **Solusi (Solutions / Control Methods)**
- Confidence levels (Very Low → Very High).
- API endpoints for integration with frontend.

---

## 🛠️ Tech Stack
- **Frontend**: HTML, CSS, JavaScript  
- **Backend**: PHP (with OOP)  
- **Database**: MySQL (schema provided in `sikar_updated.sql`)  

---

## 📂 Project Structure
plant_expert_system/
│── api/ # REST-like API endpoints
│ ├── diseases.php
│ ├── pests.php
│ ├── symptoms.php
│ ├── diagnose.php
│── classes/
│ └── ExpertSystem.php # Core logic and fuzzy methods
│── config/
│ └── database.php # Database connection
│── database/ # SQL structure and sample data
│── index.html # Frontend interface
│── js/
│ └── app.js # Frontend logic
│── css/
│ └── style.css # Styling

2. Import Database

Create a database in MySQL named sikar

Import the file:

sikar_updated.sql


This will create tables (hama, gejala, fuzzy_rules, solusi) and a penyakit view.

3. Configure Database

Edit config/database.php if needed:

private $host = 'localhost';
private $db_name = 'sikar';
private $username = 'root';
private $password = '';

4. Run Locally

Place the project in your web server root (e.g., htdocs for XAMPP or www for WAMP).

Open in browser:

http://localhost/plant_expert_system/

📡 API Endpoints

api/diseases.php → returns all diseases (from penyakit view)

api/pests.php → returns all pests (from hama table)

api/symptoms.php → returns list of symptoms

api/diagnose.php → accepts symptoms → returns diagnosis results

🧪 Example API Response

GET api/diseases.php

{
  "success": true,
  "diseases": [
    {
      "kode": "P01",
      "nama_penyakit": "Penyakit Daun",
      "nama_latin": "Fungus X",
      "deskripsi": "Infeksi jamur pada daun",
      "tingkat_bahaya": "Tinggi"
    }
  ]
}

🤝 Contributing

Fork the repo

Create a new branch (feature-xyz)

Commit changes

Open a Pull Request

📜 License

This project is licensed under the MIT License — free to use and modify.
