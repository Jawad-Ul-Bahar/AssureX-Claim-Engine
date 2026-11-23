@echo off
title AssureX Claim Engine - Server Launcher
setlocal
cd /d "%~dp0"

echo =====================================================================
echo    AssureX Claim Engine - Enterprise AI Warranty Adjudication Platform
echo =====================================================================
echo.

:: Optimization and environment flags
set "DISABLE_SQLALCHEMY_CEXT=1"
set "OPENBLAS_NUM_THREADS=1"
set "OMP_NUM_THREADS=1"
set "MKL_NUM_THREADS=1"
set "TF_NUM_INTRAOP_THREADS=1"
set "TF_NUM_INTEROP_THREADS=1"
set "TF_CPP_MIN_LOG_LEVEL=2"

:: Locate Python virtual environment
set "PYTHON_EXE="
if exist ".venv\Scripts\python.exe" set "PYTHON_EXE=%CD%\.venv\Scripts\python.exe"
if not defined PYTHON_EXE if exist "..\.venv\Scripts\python.exe" set "PYTHON_EXE=%CD%\..\.venv\Scripts\python.exe"
if not defined PYTHON_EXE if exist "..\..\.runtime\Scripts\python.exe" set "PYTHON_EXE=%CD%\..\..\.runtime\Scripts\python.exe"
if not defined PYTHON_EXE if exist "..\..\techwiz-main\.venv\Scripts\python.exe" set "PYTHON_EXE=%CD%\..\..\techwiz-main\.venv\Scripts\python.exe"

if not defined PYTHON_EXE (
    echo [WARNING] Python environment not found. Running setup.bat...
    call setup.bat
    if exist ".venv\Scripts\python.exe" set "PYTHON_EXE=%CD%\.venv\Scripts\python.exe"
)

if not defined PYTHON_EXE (
    echo [ERROR] Python environment could not be initialized. Please run setup.bat.
    pause
    exit /b 1
)

echo [1/2] Verifying Python environment...
"%PYTHON_EXE%" -c "import fastapi,sqlalchemy; print('[INFO] Web engine modules verified.')"
if errorlevel 1 (
    echo [ERROR] The Python environment is incomplete. Please run setup.bat.
    pause
    exit /b 1
)

echo.
echo [2/2] Launching server at http://127.0.0.1:8000 ...
echo [INFO] Browser will open automatically once the server is ready.
echo [INFO] Press Ctrl+C to stop the server at any time.
echo.

"%PYTHON_EXE%" launch.py
if errorlevel 1 pause
