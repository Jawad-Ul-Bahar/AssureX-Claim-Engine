# AssureX Claim Engine — Enterprise AI Warranty Adjudication Platform

[![GitHub Repository](https://img.shields.io/badge/GitHub-Jawad--Ul--Bahar%2FAssureX--Claim--Engine-blue?logo=github)](https://github.com/Jawad-Ul-Bahar/AssureX-Claim-Engine)
[![Python 3.11+](https://img.shields.io/badge/Python-3.11%20%7C%203.12%20%7C%203.15-green.svg?logo=python)](https://www.python.org/)
[![FastAPI](https://img.shields.io/badge/Framework-FastAPI-teal.svg?logo=fastapi)](https://fastapi.tiangolo.com/)
[![Tests Passing](https://img.shields.io/badge/Tests-35%2F35%20Passing-brightgreen.svg?logo=pytest)](08%20Test%20Cases%20and%20Results/)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](LICENSE)

---

### 👤 Project Lead & Core Maintainer
**Jawad Ul Bahar**  
*Lead Systems Integration, Dual-Model Decision Fusion Engine, Quality Assurance & Cloud Deployment*  
🔗 **Portfolio Repository:** [https://github.com/Jawad-Ul-Bahar/AssureX-Claim-Engine](https://github.com/Jawad-Ul-Bahar/AssureX-Claim-Engine)

> **Executive Overview:** AssureX Claim Engine is a production-grade, enterprise AI warranty claim validation and anti-fraud platform. It combines tabular machine learning (XGBoost 91.56% benchmark accuracy), deep learning computer vision (Google Teachable Machine Keras CNN), deterministic rule-based category policy evaluation, and automated document OCR with cryptographic SHA-256 duplicate detection. Designed for high-throughput warranty providers, consumer electronics brands, and insurance operations.

| Metric / Dimension | Specification |
| :--- | :--- |
| **Project Lead** | **Jawad Ul Bahar** |
| **Official Repository** | [https://github.com/Jawad-Ul-Bahar/AssureX-Claim-Engine](https://github.com/Jawad-Ul-Bahar/AssureX-Claim-Engine) |
| **Core Framework** | FastAPI (Python 3.11+) + Jinja2 Glassmorphic UI + SQLAlchemy ORM |
| **AI / ML Pipeline** | XGBoost Tabular Classifier + Google Teachable Machine CNN + Decision Fusion Engine |
| **Document Ops & Anti-Fraud** | EasyOCR / PyMuPDF Ingestion + SHA-256 Duplicate Receipt Hashing |
| **Test Verification** | 35 Automated Pytest Suites Passing (100% of 11 Mandatory SRS Scenarios) |
| **Event & Theme** | Aptech Techwiz — NextWave AI & ML (AI-Powered Document Ops) |

---

## ⚡ Quick Start & Execution

The application is completely self-contained with pre-seeded demonstration data and an isolated environment setup.

### 1. One-Click Launch (Windows)
Double-click **`run_app.bat`** in the root directory:
- Cleans up and frees port 8000 automatically.
- Initializes the SQLite database if not present.
- Launches the Uvicorn web server.
- Automatically launches your default web browser at **`http://127.0.0.1:8000`**.

### 2. Manual Command Line Setup (Windows / Linux / macOS)
```bash
# Clone the repository
git clone https://github.com/Jawad-Ul-Bahar/AssureX-Claim-Engine.git
cd AssureX-Claim-Engine/"02 Source Repository"

# Create and activate virtual environment
python -m venv .venv
# On Windows: .venv\Scripts\activate
# On Linux/macOS: source .venv/bin/activate

# Install dependencies (or use uv: uv pip install -r requirements.txt)
pip install -r requirements.txt

# Run server launcher
python launch.py
```
Open **`http://127.0.0.1:8000`** in your browser.

---

## ☁️ Cloud Deployment (Render.com — Free Tier)

This project ships a [`render.yaml`](render.yaml) for one-click deployment to [Render.com](https://render.com) (free tier).

### Steps to Deploy
1. **Fork** this repository to your GitHub account (or push your clone).
2. Go to [render.com](https://render.com) → **New → Web Service** and connect your repository.
3. Render auto-detects `render.yaml` and pre-fills build/start commands.
4. In **Environment**, confirm `SECRET_KEY` is set (Render generates it automatically via `render.yaml`).
5. Click **Create Web Service** → Render builds and deploys.

### Environment Variables (pre-configured in `render.yaml`)
| Variable | Value | Purpose |
| :--- | :--- | :--- |
| `SECRET_KEY` | *(auto-generated)* | FastAPI session signing key |
| `DISABLE_SQLALCHEMY_CEXT` | `1` | Force SQLAlchemy pure-Python mode |
| `PYTHONPATH` | `src:.` | Python package resolution |
| `OPENBLAS_NUM_THREADS` / `OMP_NUM_THREADS` | `1` | Prevent OOM on 512 MB free tier |

### ⚠️ Free Tier Constraints
- **SQLite database resets on every restart** (ephemeral disk on free tier). Pre-seeded demo data will be re-initialised from scratch; no user-submitted data persists across deploys. For persistence, upgrade to a paid Render plan or migrate to PostgreSQL.
- The service **spins down after 15 minutes of inactivity**. The first request after spin-down may take 30–60 seconds.
- `demo_video.mp4` is not included in the repository (203 MB — too large for GitHub). Host it on YouTube or Google Drive and link it here once published.

---

## 🔑 Pre-Seeded Evaluation Credentials

Test accounts are pre-configured to evaluate all Role-Based Access Control (RBAC) workflows:

| Role | Email / Username | Password | Key Capabilities |
| :--- | :--- | :--- | :--- |
| **Administrator** | `admin@assurex.com` | `admin123` | System analytics dashboard, audit trail, downloadable reports, metric monitoring |
| **Claim Reviewer** | `reviewer@assurex.com` | `reviewer123` | Reviewer Queue adjudication, decision override with mandatory reason logging |
| **Service Center** | `service@assurex.com` | `service123` | Claim intake, receipt OCR verification, warranty status checks |
| **Customer** | `customer@assurex.com` | `customer123` | Claim submission, product registration, status timeline tracking |

---

## 🏗️ System Architecture & Dual-Model AI

AssureX Claim Engine processes claims using a multi-stage defense-in-depth pipeline:

```
[Document Upload] ──> [OCR Extraction & SHA-256 Hashing]
                                │
       ┌────────────────────────┴────────────────────────┐
       ▼                                                 ▼
[Tabular Record]                              [Claim Summary Card]
       │                                                 │
       ▼                                                 ▼
[XGBoost Classifier]                          [Google Teachable Machine CNN]
(Likely Valid / Invalid / Review)             (Visual Card Classification)
       │                                                 │
       └────────────────────────┬────────────────────────┘
                                ▼
               [Dual-Model Comparison & Consistency]
                                │
               [Warranty Policy Rule Engine (JSON)]
                                │
               [Decision Fusion & Contradiction Engine]
                                │
            ┌───────────────────┼───────────────────┐
            ▼                   ▼                   ▼
    🟢 Likely Valid     🔴 Likely Invalid   🟡 Manual Review
    (Auto-Approve)       (Auto-Reject)       (Reviewer Queue)
```

1. **Document Ingestion & OCR:** Extracts customer details, purchase dates, and serial numbers with PyMuPDF/EasyOCR. SHA-256 receipt hashing prevents duplicate claim fraud.
2. **Tabular Machine Learning Model:** An XGBoost classifier trained on 1,500 balanced records predicts claim validity (`Likely Valid`, `Likely Invalid`, `Manual Review`).
3. **Computer Vision Model (Google Teachable Machine):** Generates standardized visual Claim Summary Cards without decision leakage, classified via a Keras Deep Learning CNN (`keras_model.h5`).
4. **Warranty Policy Engine:** JSON-driven rule validation for coverage windows, proof of purchase, authorized repair history, and excluded damages (liquid spill, unauthorized modification).
5. **Decision Fusion Engine:** Reconciles model outputs and policy rules:
   - When models agree and policy passes $\rightarrow$ **Auto-Approval Candidate** (`Likely Valid`).
   - When excluded conditions are detected $\rightarrow$ **Auto-Rejection Candidate** (`Likely Invalid`).
   - When models diverge, confidence is low, or documents are missing $\rightarrow$ **Flagged for Human Reviewer** (`Manual Review Required`).

---

## 🧪 Automated Testing & SRS Verification

The full pytest suite validates all **11 mandatory SRS scenarios** and core modules:
```bash
cd "02 Source Repository"
pytest tests -v
```

### Verified Test Suite (35/35 Passing):
- [x] **Scenario 1:** Valid Claim (Passed rules, high dual-model confidence)
- [x] **Scenario 2:** Invalid Claim (Excluded damage / liquid spill hard-fail)
- [x] **Scenario 3:** Manual Review (Borderline features / missing receipt)
- [x] **Scenario 4:** Expired Warranty (Claim submission past warranty end date)
- [x] **Scenario 5:** Missing Document Alert (Receipt or serial photo missing)
- [x] **Scenario 6:** Duplicate Claim Detection (Matching document hash or serial)
- [x] **Scenario 7:** Contradictory Timeline (Fault date prior to purchase date)
- [x] **Scenario 8:** Serial Number Mismatch (User serial vs OCR extracted serial)
- [x] **Scenario 9:** Unauthorized Repair (Previous repair by unauthorized center)
- [x] **Scenario 10:** Tricky Boundary Date (Claim filed on exact last day of coverage)
- [x] **Scenario 11:** Model Disagreement (Python ML vs Vision model conflict routed to Reviewer)
- [x] **Security & RBAC:** Role restrictions, password hashing, session cleanup, vector PDF reporting

---

## 📂 Deliverables Directory Map (16 Modules per Aptech SRS v1.0)

| Folder | Name | Highlights & Key Files |
| :---: | :--- | :--- |
| **01** | `01 Project Report` | Comprehensive documentation, architecture diagrams, database dictionary |
| **02** | `02 Source Repository` | Production FastAPI codebase, Jinja2 UI, ML models, DB, tests, `run_app.bat` |
| **03** | `03 Common Dataset` | 1,500 balanced synthetic claim records (CSV), 2,550 visual Claim Summary Cards |
| **04** | `04 Python Model Evidence` | Trained XGBoost model (`best_python_model.joblib`), 91.56% test accuracy, classification metrics |
| **05** | `05 Teachable Machine Evidence` | Exported Google Teachable Machine Keras model (`keras_model.h5`), labels, test predictions |
| **06** | `06 Model Comparison` | 30-claim side-by-side comparison table (`comparison_table.csv`), divergence analysis |
| **07** | `07 Warranty Policies` | Configurable JSON rules for Appliances, Electronics, and Automotive; Policy Field Matrix |
| **08** | `08 Test Cases and Results` | Automated pytest results (all mandatory scenarios passing), test logs |
| **09** | `09 Installation Instructions` | Step-by-step installation manual, environment setup, OCR engine configuration |
| **10** | `10 Execution Instructions` | Complete user manual for intake, OCR verification, review routing, and admin reports |
| **11** | `11 GitHub Repository` | Commit history screenshots, contribution matrix, release records |
| **12** | `12 Deployment` | Local launch guide, cloud deployment specs (Docker/PaaS), health check validation |
| **13** | `13 Demonstration Video` | High-definition demonstration video recording script and scene guide |
| **14** | `14 Technical Blog` | Published Blogger article link, offline HTML copy (`index.html`), technical article markdown |
| **15** | `15 AI Usage Declaration` | Signed team verification table, AI tools breakdown (50% AI / 50% human) |
| **16** | `16 Final Submission Checklist` | SRS v1.0 reference specification, complete bullet-by-bullet compliance CSV matrix |

---

## 👥 Contributors & Acknowledgements

Originally developed under the team banner *SFC Karachi Coders* for the Aptech Techwiz competition:

| Name | Role | Primary Technical Contributions |
| :--- | :--- | :--- |
| **Jawad Ul Bahar** | **Project Lead & Integration Architect** | System integration, dual-model comparison fusion engine, 11 mandatory test scenarios, automated pytest test suite, deployment configuration, and repository maintenance |
| **Musab-Al-Mustafa** | Full-Stack Architect | Initial web architecture, UI/UX glassmorphism templates, tabular ML model benchmarking |
| **Abdullah Murshid** | Data Engineer | Synthetic dataset generation (1,500 rows), summary card generator, feature engineering |
| **Abdul Rehman** | Backend Engineer | FastAPI routes, SQLite ORM database schema, OCR pipeline & hash security |
| **Umer Tak** | Vision Specialist | Google Teachable Machine model training, Keras H5 export, visual card classification |

---

*AssureX Claim Engine — Developed and Maintained by [Jawad Ul Bahar](https://github.com/Jawad-Ul-Bahar/AssureX-Claim-Engine).*
