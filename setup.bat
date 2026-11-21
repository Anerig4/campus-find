@echo off
title CampusFind - Smart Lost ^& Found Management System Setup
echo ============================================================
echo   CampusFind: Smart Lost ^& Found Management System
echo   Project Setup Script
echo ============================================================
echo.

REM --- Step 1: Create virtual environment ---
echo [1/5] Creating Python virtual environment...
python -m venv venv
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to create virtual environment.
    echo        Make sure Python 3.10+ is installed and added to PATH.
    pause
    exit /b 1
)
echo       Virtual environment created successfully.
echo.

REM --- Step 2: Activate virtual environment ---
echo [2/5] Activating virtual environment...
call venv\Scripts\activate.bat
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to activate virtual environment.
    pause
    exit /b 1
)
echo       Virtual environment activated.
echo.

REM --- Step 3: Install dependencies ---
echo [3/5] Installing dependencies from requirements.txt...
pip install --upgrade pip
pip install -r requirements.txt
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to install dependencies.
    pause
    exit /b 1
)
echo       Dependencies installed successfully.
echo.

REM --- Step 4: Run database migrations ---
echo [4/5] Running database migrations...
python manage.py makemigrations accounts
python manage.py makemigrations items
python manage.py migrate
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to run migrations.
    pause
    exit /b 1
)
echo       Database migrations applied successfully.
echo.

REM --- Step 5: Seed Demo Data ---
echo [5/6] Seeding Initial Demo Data (Categories, Locations, Sample Items)...
python manage.py seed_data
echo.

REM --- Step 6: Create superuser ---
echo [6/6] Create a custom superuser account (Optional - 'admin' / 'admin123' already seeded):
set /p CREATE_SUPER="Do you want to create another superuser now? (y/n): "
if /i "%CREATE_SUPER%"=="y" (
    python manage.py createsuperuser
)
echo.

REM --- Done: Start development server ---
echo ============================================================
echo   Setup complete!
echo   Starting development server at http://127.0.0.1:8000/
echo   Press Ctrl+C to stop the server.
echo ============================================================
echo.
python manage.py runserver
