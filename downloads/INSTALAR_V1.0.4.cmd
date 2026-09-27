@echo off
setlocal
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0INSTALAR_V1.0.4.ps1"
if errorlevel 1 (
  echo.
  echo La instalacion se ha detenido. Revisa el mensaje anterior.
  pause
)
endlocal
