# 🔍 CampusFind: Smart Lost & Found Management System

> **Jaypee Institute of Information Technology (JIIT)**  
> **Course:** Full Stack Development Lab (`24B15CS314`) — Semester 5 (Odd Semester 2026)  
> **Submitted To:** Mr. Kashav Ajmera  
> **Submitted By:**  
> - **Aneri Gupta** — `992401030164`  
> - **Adhira Sethi** — `992401030169`  
> - **Tarushi Goel** — `992401030173`  

---

## 📌 1. Project Overview

**CampusFind** is a Django-based full-stack web application designed to manage the complete lifecycle of lost and found items across a college campus. 

Currently, lost-and-found activities on campuses depend on scattered WhatsApp groups, security desks, and notice boards where messages get buried and items go unclaimed. CampusFind provides a centralized, authenticated platform where students, faculty, and staff can report misplaced belongings, receive smart match suggestions, submit ownership claims, and track cases until safe return.

---

## 🚀 2. Key Features

- **Structured Item Reporting:** Capture item name, category, color, location/building, date, description, photo upload, and *secret identifying features* (hidden proof).
- **Explainable Rule-Based Matching Engine:** Transparent weighted scoring (0–100%) comparing Lost and Found records:
  - Category Match: `30%`
  - Color Match: `20%`
  - Location Match: `20%`
  - Date Proximity: `15%`
  - Text Similarity: `15%`
- **Real-Time AJAX Live Search:** Instant keyword and parameter filtering using JavaScript Fetch API without full page refreshes.
- **Controlled Ownership Claim & Verification:**
  - Claimants must provide secret identifying features to prove ownership.
  - Administrators review claimant proof against original report details.
  - State machine: `Pending` ➔ `Under Verification` ➔ `Approved/Rejected` ➔ `Returned`.
- **Role-Based Dashboards:**
  - **Student / Staff:** Personal dashboard showing reported items, active searches, claim status, and possible matches.
  - **Administrator:** Central command center with campus metrics, claim decision modals, and verification controls.
- **Institutional Reporting & Exports:**
  - Export all records to **CSV**.
  - Generate printable **PDF** summary reports with tables and charts using ReportLab.
- **Audit History Timeline:** Every status change is logged with timestamp, user, and notes.

---

## 🛠️ 3. Technology Stack

| Layer | Technologies |
|---|---|
| **Backend** | Python 3.10+, Django 5.x (MVT Architecture) |
| **Database** | SQLite3 with Django ORM |
| **Frontend** | HTML5, CSS3, Bootstrap 5.3, Bootstrap Icons, JavaScript (Fetch API) |
| **Libraries** | `Pillow` (Image Processing), `reportlab` (PDF Generation), `django-widget-tweaks` |
| **Authentication** | Django Auth with `CustomUser` model (Student, Staff, Admin) |

---

## 📂 4. Project Directory Structure

```
CampusFind/
├── accounts/                  # User Authentication & CustomUser App
│   ├── models.py              # CustomUser with role, enrollment_number, etc.
│   ├── forms.py               # Registration & Login forms
│   ├── views.py               # Register, Login, Logout, Profile views
│   └── urls.py
├── campusfind/                # Django Project Configuration
│   ├── settings.py            # SQLite, static, media, auth settings
│   ├── urls.py                # Main URL router
│   ├── wsgi.py
│   └── asgi.py
├── items/                     # Core Lost & Found Application
│   ├── models.py              # Category, Location, ItemReport, Claim, StatusHistory
│   ├── forms.py               # ItemReportForm, ClaimForm, ItemSearchForm
│   ├── matching.py            # Rule-based similarity scoring algorithm
│   ├── views.py               # CRUD, Search, Claim, Admin, Export views
│   ├── urls.py
│   ├── templatetags/          # Custom filters (status_badge, percentage)
│   └── management/commands/
│       └── seed_data.py       # Comprehensive sample data seeder
├── templates/                 # Bootstrap 5 HTML Templates
│   ├── base.html              # Base layout with navbar & footer
│   ├── home.html              # Landing page with live metrics
│   ├── accounts/              # register.html, login.html, profile.html
│   └── items/                 # dashboard, report_form, report_detail, search, admin...
├── static/                    # Static Assets
│   ├── css/style.css          # Custom styling & animations
│   └── js/main.js             # AJAX search & image preview logic
├── media/                     # User-uploaded item photos
├── requirements.txt           # Project dependencies
├── setup.bat                  # One-click Windows setup script
└── manage.py
```

---

## ⚡ 5. Setup & Installation (Windows)

### Quick One-Click Setup
If you are on Windows, simply double-click or run:
```cmd
setup.bat
```

### Manual Step-by-Step Setup

1. **Install Python 3** (if not already installed from [python.org](https://www.python.org/downloads/)). Make sure to check *"Add python.exe to PATH"*.

2. **Navigate to the Project Directory:**
   ```cmd
   cd C:\Users\Aneri\.gemini\antigravity\scratch\CampusFind
   ```

3. **Create and Activate a Virtual Environment:**
   ```cmd
   python -m venv venv
   venv\Scripts\activate
   ```

4. **Install Dependencies:**
   ```cmd
   pip install -r requirements.txt
   ```

5. **Run Database Migrations:**
   ```cmd
   python manage.py makemigrations accounts
   python manage.py makemigrations items
   python manage.py migrate
   ```

6. **Seed Initial Demo Data (Categories, Locations, Sample Reports & Users):**
   ```cmd
   python manage.py seed_data
   ```

7. **Start the Development Server:**
   ```cmd
   python manage.py runserver
   ```

8. **Open in Browser:**  
   Navigate to [http://127.0.0.1:8000/](http://127.0.0.1:8000/)

---

## 🔑 6. Default Demo Accounts

The `python manage.py seed_data` command generates pre-configured accounts:

| Role | Username | Password | Notes |
|---|---|---|---|
| **Administrator** | `admin` | `admin123` | Full access to Admin Dashboard, claims approval, CSV/PDF exports |
| **Student 1** | `aneri` | `aneri123` | Student account (`992401030164`), reported sample items |
| **Student 2** | `adhira` | `adhira123` | Student account (`992401030169`), reported sample items |
| **Student 3** | `tarushi` | `tarushi123` | Student account (`992401030173`), reported sample items |

*You can also create your own custom account via the **Register** page.*

---

## 🔄 7. Complete System Workflow

```
[Student Reports Lost Item]      [Student Reports Found Item]
             \                               /
              \                             /
        [CampusFind Centralized Database Catalog]
                         |
           [Rule-Based Match Scoring & AJAX Search]
                         |
           [Owner Submits Claim with Secret Proof]
                         |
              [Admin Review & Verification]
                   /                 \
        [Approved]                     [Rejected]
            |                              |
    [Item Handover]               [Notification Sent]
            |
    [Status ➔ Resolved/Closed]
```

---

## 📄 8. Academic References

- Django Documentation: [https://docs.djangoproject.com/](https://docs.djangoproject.com/)
- W. S. Vincent, *Django for Beginners: Build Websites with Python and Django*, 5th ed., 2025.
- A. Melé, *Django 5 By Example*, 5th ed., Packt Publishing, 2024.
