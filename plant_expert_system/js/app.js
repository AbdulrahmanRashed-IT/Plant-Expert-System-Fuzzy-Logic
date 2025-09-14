class PlantExpertSystem {
  constructor() {
    this.selectedSymptoms = new Set()
    this.allSymptoms = []
    this.allDiseases = [] // Renamed from allPests for consistency with 'diseases' API endpoint
    this.init()
  }

  async init() {
    this.setupEventListeners()
    await this.loadSymptoms()
    await this.loadDiseases() // Changed from loadPests
    this.renderSymptoms()
  }

  setupEventListeners() {
    // Tab navigation
    document.querySelectorAll(".nav-btn").forEach((btn) => {
      btn.addEventListener("click", (e) => {
        this.switchTab(e.target.dataset.tab)
      })
    })

    // Symptom search
    document.getElementById("symptom-search").addEventListener("input", (e) => {
      this.filterSymptoms(e.target.value)
    })

    // Diagnose button
    document.getElementById("diagnose-btn").addEventListener("click", () => {
      this.performDiagnosis()
    })

    // Disease selection for backward chaining
    document.getElementById("disease-select").addEventListener("change", (e) => {
      if (e.target.value) {
        this.performBackwardChaining(e.target.value)
      } else {
        document.getElementById("backward-results").classList.add("hidden")
      }
    })
  }

  switchTab(tabName) {
    // Update nav buttons
    document.querySelectorAll(".nav-btn").forEach((btn) => {
      btn.classList.remove("active")
    })
    document.querySelector(`[data-tab="${tabName}"]`).classList.add("active")

    // Update tab content
    document.querySelectorAll(".tab-content").forEach((content) => {
      content.classList.remove("active")
    })
    document.getElementById(tabName).classList.add("active")
  }

  async loadSymptoms() {
    try {
      const response = await fetch("api/symptoms.php")
      const data = await response.json()
      if (data.success) {
        this.allSymptoms = data.symptoms
      } else {
        this.showError(data.error || "Gagal memuat data gejala")
      }
    } catch (error) {
      console.error("Error loading symptoms:", error)
      this.showError("Gagal memuat data gejala")
    }
  }

  async loadDiseases() { // Changed from loadPests
    try {
      const response = await fetch("api/diseases.php") // Changed endpoint to diseases.php
      const data = await response.json()
      if (data.success) {
        this.allDiseases = data.diseases // Data key is 'diseases' from diseases.php
        this.populateDiseaseSelect()
      } else {
        this.showError(data.error || "Gagal memuat data penyakit")
      }
    } catch (error) {
      console.error("Error loading diseases:", error)
      this.showError("Gagal memuat data penyakit")
    }
  }

  populateDiseaseSelect() {
    const select = document.getElementById("disease-select")
    select.innerHTML = '<option value="">-- Pilih Hama --</option>' // Changed "Penyakit" to "Hama"

    this.allDiseases.forEach((disease) => { // Iterating through 'allDiseases'
      const option = document.createElement("option")
      option.value = disease.kode
      option.textContent = `${disease.kode} - ${disease.nama_penyakit}`
      select.appendChild(option)
    })
  }

  renderSymptoms(symptoms = this.allSymptoms) {
    const grid = document.getElementById("symptoms-grid")
    grid.innerHTML = ""

    symptoms.forEach((symptom) => {
      const card = document.createElement("div")
      card.className = `symptom-card ${this.selectedSymptoms.has(symptom.kd_gejala) ? "selected" : ""}`
      card.innerHTML = `
                <div class="symptom-code">${symptom.kd_gejala}</div>
                <div class="symptom-text">${symptom.gejala}</div>
            `

      card.addEventListener("click", () => {
        this.toggleSymptom(symptom.kd_gejala, symptom.gejala)
      })

      grid.appendChild(card)
    })
  }

  filterSymptoms(searchTerm) {
    const filtered = this.allSymptoms.filter(
      (symptom) =>
        symptom.gejala.toLowerCase().includes(searchTerm.toLowerCase()) ||
        symptom.kd_gejala.toLowerCase().includes(searchTerm.toLowerCase()),
    )
    this.renderSymptoms(filtered)
  }

  toggleSymptom(code, text) {
    if (this.selectedSymptoms.has(code)) {
      this.selectedSymptoms.delete(code)
    } else {
      this.selectedSymptoms.add(code)
    }

    this.updateSelectedSymptoms()
    this.renderSymptoms() // Re-render symptoms to update 'selected' class
  }

  updateSelectedSymptoms() {
    const container = document.getElementById("selected-symptoms")
    const count = document.getElementById("selected-count")
    const diagnoseBtn = document.getElementById("diagnose-btn")

    count.textContent = this.selectedSymptoms.size

    container.innerHTML = ""
    this.selectedSymptoms.forEach((code) => {
      const symptom = this.allSymptoms.find((s) => s.kd_gejala === code)
      if (symptom) {
        const item = document.createElement("div")
        item.className = "selected-item"
        item.innerHTML = `
                    <span>${symptom.kd_gejala}</span>
                    <button class="remove-symptom" onclick="expertSystem.toggleSymptom('${code}', '${symptom.gejala.replace(/'/g, "\\'")}')">×</button>
                ` // Escaped single quotes in symptom.gejala for onclick
        container.appendChild(item)
      }
    })

    diagnoseBtn.disabled = this.selectedSymptoms.size === 0
  }

  async performDiagnosis() {
    if (this.selectedSymptoms.size === 0) return

    this.showLoading(true)

    try {
      const response = await fetch("api/diagnose.php", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          symptoms: Array.from(this.selectedSymptoms),
        }),
      })

      const data = await response.json()

      if (response.ok && data.success) { // Check response.ok for HTTP status
        this.displayResults(data.results)
      } else {
        this.showError(data.error || "Terjadi kesalahan saat diagnosa")
      }
    } catch (error) {
      console.error("Error performing diagnosis:", error)
      this.showError("Gagal melakukan diagnosa")
    } finally {
      this.showLoading(false)
    }
  }

  displayResults(results) {
    const resultsSection = document.getElementById("results-section")
    const resultsContainer = document.getElementById("diagnosis-results")

    resultsSection.classList.remove("hidden")
    resultsContainer.innerHTML = ""

    if (results.length === 0) {
      resultsContainer.innerHTML = `
                <div class="result-card">
                    <div class="text-center">
                        <h4>Tidak Ada Diagnosa Ditemukan</h4>
                        <p>Kombinasi gejala yang dipilih tidak cocok dengan penyakit yang ada dalam database. Silakan periksa kembali gejala atau konsultasi dengan ahli.</p>
                    </div>
                </div>
            `
      return
    }

    results.forEach((result) => {
      const card = document.createElement("div")
      card.className = "result-card"

      const confidenceClass = this.getConfidenceClass(result.confidence)
      // 'matched_symptoms' from backend is the array of symptom codes sent by user.
      // We need to map these codes to their full symptom text.
      const matchedSymptomsText = result.matched_symptoms.map((code) => {
        const symptom = this.allSymptoms.find((s) => s.kd_gejala === code)
        return symptom ? symptom.gejala : code // Display full text or code if not found
      })

      card.innerHTML = `
                <div class="result-header">
                    <div class="disease-info">
                        <h4>${result.disease.nama_penyakit}</h4>
                        <p class="disease-cause"><strong>Penyebab:</strong> ${result.disease.deskripsi || 'Tidak ada deskripsi'}</p>
                        <p class="disease-cause"><strong>Nama Latin:</strong> ${result.disease.nama_latin || 'Tidak diketahui'}</p>
                        <div class="danger-level">
                            <span>Tingkat Bahaya: </span>
                            <span class="danger-badge">${result.disease.tingkat_bahaya || 'Tidak diketahui'}</span>
                        </div>
                    </div>
                    <div class="confidence-badge ${confidenceClass}">
                        ${Math.round(result.confidence)}% Yakin
                    </div>
                </div>
                
                <div class="matched-symptoms">
                    <h5>Gejala yang Cocok:</h5>
                    <div class="symptom-list">
                        ${matchedSymptomsText.map((text) => `<span class="symptom-tag">${text}</span>`).join("")}
                    </div>
                </div>
                
                <div class="solutions-section">
                    <h5>Solusi Pengobatan:</h5>
                    ${this.renderSolutions(result.solutions)}
                </div>
            `

      resultsContainer.appendChild(card)
    })

    // Scroll to results
    resultsSection.scrollIntoView({ behavior: "smooth" })
  }

  renderSolutions(solutions) {
    if (!solutions || solutions.length === 0) {
      return "<p>Tidak ada solusi tersedia untuk penyakit ini.</p>"
    }

    return solutions
      .map(
        (solution) => `
            <div class="solution-item">
                <div class="solution-name">${solution.nama_obat}</div>
                <div class="solution-details">${solution.solusi}</div>
            </div>
        `,
      )
      .join("")
  }

  getConfidenceClass(confidence) {
    if (confidence >= 80) return "confidence-high"
    if (confidence >= 60) return "confidence-medium"
    return "confidence-low"
  }

  async performBackwardChaining(diseaseCode) {
    this.showLoading(true)

    try {
      const response = await fetch("api/backward.php", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          disease_code: diseaseCode, // Changed 'pest_code' to 'disease_code'
        }),
      })

      const data = await response.json()

      if (response.ok && data.success) { // Check response.ok for HTTP status
        this.displayBackwardResults(data)
      } else {
        this.showError(data.error || "Terjadi kesalahan saat analisis")
      }
    } catch (error) {
      console.error("Error performing backward chaining:", error)
      this.showError("Gagal melakukan analisis")
    } finally {
      this.showLoading(false)
    }
  }

  displayBackwardResults(data) {
    const resultsSection = document.getElementById("backward-results")

    // Disease info
    document.getElementById("pest-name").textContent = data.pest.nama_penyakit // Use data.pest
    document.getElementById("pest-latin").textContent = data.pest.nama_latin || 'Tidak diketahui'
    document.getElementById("pest-description").textContent = data.pest.deskripsi || 'Tidak ada deskripsi'
    document.getElementById("danger-level").textContent = data.pest.tingkat_bahaya || 'Tidak diketahui'

    // Required symptoms
    const symptomsList = document.getElementById("required-symptoms-list")
    symptomsList.innerHTML = ""

    if (data.required_symptoms.length === 0) {
      symptomsList.innerHTML = "<p>Tidak ada gejala spesifik yang diperlukan.</p>"
    } else {
      data.required_symptoms.forEach((symptom) => {
        const item = document.createElement("div")
        item.className = "symptom-item"
        item.innerHTML = `
                    <div class="symptom-item-code">${symptom.kd_gejala}</div>
                    <div class="symptom-item-text">${symptom.gejala}</div>
                `
        symptomsList.appendChild(item)
      })
    }

    // Solutions (control methods)
    const solutionsList = document.getElementById("solutions-list") // Corrected ID
    solutionsList.innerHTML = this.renderSolutions(data.control_methods) // Use data.control_methods

    resultsSection.classList.remove("hidden")
  }

  showLoading(show) {
    const overlay = document.getElementById("loading-overlay")
    if (show) {
      overlay.classList.remove("hidden")
    } else {
      overlay.classList.add("hidden")
    }
  }

  showError(message) {
    alert(message) // In a real app, you'd use a better notification system
  }
}

// Initialize the expert system when the page loads
let expertSystem
document.addEventListener("DOMContentLoaded", () => {
  expertSystem = new PlantExpertSystem()
})
document.addEventListener("DOMContentLoaded", () => {
  const searchInput = document.getElementById("searchSymptom");
  const searchBtn = document.getElementById("searchBtn");

  // Function to fetch symptoms
  function searchSymptoms() {
    const keyword = searchInput.value.trim();
    if (!keyword) return;

    fetch(`api/symptoms.php?search=${encodeURIComponent(keyword)}`)
      .then(res => res.json())
      .then(data => {
        if (data.success) {
          // Example: show results in console or append to a list
          console.log("Symptoms found:", data.symptoms);

          // You can replace this with code to render results in your UI
          alert(`Found ${data.symptoms.length} symptoms matching "${keyword}"`);
        } else {
          alert("No symptoms found!");
        }
      })
      .catch(err => console.error("Error:", err));
  }

  // Click search icon
  searchBtn.addEventListener("click", searchSymptoms);

  // Press Enter key
  searchInput.addEventListener("keypress", (e) => {
    if (e.key === "Enter") {
      searchSymptoms();
    }
  });
});
