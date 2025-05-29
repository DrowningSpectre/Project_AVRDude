@echo off
setlocal

REM Default Einstellungen
set PROGRAMMER=avrispmkii
set CHIP=attiny85
set PORT=usb
set BAUD=57600
set CONF=Tools\avrdude\avrdude.conf

REM Prüfen, ob erster Parameter (Hex-Datei) gesetzt ist
if "%1"=="" (
    echo Please provide the hex file as first parameter.
    echo Example: upload.bat myfile.hex [programmer] [chip] [port] [baud]
    goto :eof
)
set HEXFILE=%1

REM Optional: Falls weitere Parameter gesetzt sind, überschreiben sie die Defaults
if not "%2"=="" set PROGRAMMER=%2
if not "%3"=="" set CHIP=%3
if not "%4"=="" set PORT=%4
if not "%5"=="" set BAUD=%5

echo Uploading %HEXFILE% to chip %CHIP% using programmer %PROGRAMMER% on port %PORT% with baud %BAUD%...

Tools\avrdude\avrdude.exe -p %CHIP% -c %PROGRAMMER% -b %BAUD% -P %PORT% -U flash:w:%HEXFILE%:a -C %CONF%

IF ERRORLEVEL 1 (
    echo.
    echo ERROR: Upload failed! Check your programmer, port, chip, baudrate, and filename.
    pause
    exit /b 1
) ELSE (
    echo Upload successful.
)

endlocal