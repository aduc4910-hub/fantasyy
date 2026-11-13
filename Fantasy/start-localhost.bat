@echo off
title Ashen Press - Localhost Server
cd /d "%~dp0"
echo ==========================================================
echo Starting Ashen Press 3D Book Shelf on Localhost...
echo ==========================================================
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0server.ps1"
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Server stopped with an error.
    pause
)
