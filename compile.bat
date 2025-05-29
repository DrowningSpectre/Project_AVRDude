@echo off
setlocal

REM Check if a parameter (asm file) is provided
if "%1"=="" (
    echo Please provide the ASM filename as a parameter.
    echo Example: compile.bat myfile.asm
    goto :eof
)

REM Set paths relative to this script
set TOOLS=%~dp0Tools
set SRC=%~dp0
set FILE=%1

echo Compiling %FILE%...

"%TOOLS%\avrabin\avra.exe" "%SRC%%FILE%" -I "%SRC%includes"
IF ERRORLEVEL 1 (
    echo.
    echo ERROR: Compilation failed! Please check your source file and include paths.
    pause
    exit /b 1
) ELSE (
    echo Compilation successful.
)

endlocal