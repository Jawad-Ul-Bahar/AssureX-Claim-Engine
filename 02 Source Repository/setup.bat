@echo off
title AssureX Claim Engine - Setup
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo =====================================================================
echo    AssureX Claim Engine - Environment Setup
echo =====================================================================
echo.

set "DISABLE_SQLALCHEMY_CEXT=1"

:: 1. Check if .venv already exists
if exist ".venv\Scripts\python.exe" (
    echo [INFO] Virtual environment .venv already exists.
    goto :install_deps
)

:: 2. Find tool to create virtual environment (uv, py, or python)
set "UV_CMD="
if exist "%USERPROFILE%\.local\bin\uv.exe" set "UV_CMD=%USERPROFILE%\.local\bin\uv.exe"
if not defined UV_CMD where.exe uv >nul 2>&1 && set "UV_CMD=uv"

if defined UV_CMD (
    echo [INFO] Creating virtual environment using uv...
    "%UV_CMD%" venv .venv
    if exist ".venv\Scripts\python.exe" goto :install_deps
)

where.exe py >nul 2>&1
if not errorlevel 1 (
    echo [INFO] Creating virtual environment using py launcher...
    py -3 -m venv .venv 2>nul || py -m venv .venv
    if exist ".venv\Scripts\python.exe" goto :install_deps
)

where.exe python >nul 2>&1
if not errorlevel 1 (
    echo [INFO] Creating virtual environment using system python...
    python -m venv .venv
    if exist ".venv\Scripts\python.exe" goto :install_deps
)

echo [ERROR] No suitable Python interpreter found to create virtual environment.
echo Please install Python 3.11+ from https://www.python.org/downloads/
echo or ensure python/py/uv is added to your PATH.
pause
exit /b 1

:install_deps
echo.
echo [INFO] Installing project dependencies from requirements.txt...
if defined UV_CMD (
    "%UV_CMD%" pip install --python ".venv\Scripts\python.exe" -r requirements.txt
) else (
    ".venv\Scripts\python.exe" -m pip install --upgrade pip
    ".venv\Scripts\python.exe" -m pip install -r requirements.txt
)

if errorlevel 1 (
    echo [WARNING] Some dependencies had warnings during installation.
)

echo.
echo [INFO] Initializing SQLite database...
set "PYTHONPATH=src;."
".venv\Scripts\python.exe" -c "from assurex_claim_engine.db.database import init_db; init_db()" >nul 2>&1

echo.
echo =====================================================================
echo    Installation complete! You can now run run_app.bat.
echo =====================================================================
pause
