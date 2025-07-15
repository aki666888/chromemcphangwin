@echo off
echo Chrome MCP Complete Setup for Windows
echo =====================================
echo.

REM Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Node.js is NOT installed!
    echo Please install Node.js from https://nodejs.org/ first
    pause
    exit /b 1
)

echo [STEP 1] Installing mcp-chrome-bridge...
call npm install -g mcp-chrome-bridge

echo.
echo [STEP 2] Getting Chrome Extension ID...
echo.
echo IMPORTANT: 
echo 1. Open Chrome and go to chrome://extensions
echo 2. Find "Chrome MCP Server" extension
echo 3. Copy the Extension ID
echo.
set /p EXTENSION_ID=Enter your Chrome Extension ID: 

echo.
echo [STEP 3] Creating configuration...

REM Create directories
set CONFIG_DIR=%USERPROFILE%\.config\chrome-native-messaging-hosts
if not exist "%CONFIG_DIR%" mkdir "%CONFIG_DIR%"

REM Find npm global root
for /f "delims=" %%i in ('npm root -g') do set NPM_ROOT=%%i

REM Create manifest
set MANIFEST_FILE=%CONFIG_DIR%\com.chromemcp.nativehost.json
(
echo {
echo   "name": "com.chromemcp.nativehost",
echo   "description": "Chrome MCP Server",
echo   "path": "%NPM_ROOT:\=\\%\\mcp-chrome-bridge\\dist\\run_host.bat",
echo   "type": "stdio",
echo   "allowed_origins": [
echo     "chrome-extension://%EXTENSION_ID%/"
echo   ]
echo }
) > "%MANIFEST_FILE%"

echo.
echo [STEP 4] Registering with Chrome...
REG ADD "HKCU\Software\Google\Chrome\NativeMessagingHosts\com.chromemcp.nativehost" /ve /t REG_SZ /d "%MANIFEST_FILE%" /f

echo.
echo [STEP 5] Creating Claude Desktop config directory...
set CLAUDE_CONFIG_DIR=%APPDATA%\Claude
if not exist "%CLAUDE_CONFIG_DIR%" mkdir "%CLAUDE_CONFIG_DIR%"

echo.
echo =====================================
echo SETUP COMPLETE!
echo =====================================
echo.
echo Next steps:
echo 1. Close ALL Chrome windows
echo 2. Restart Chrome
echo 3. Click the Chrome MCP extension and Connect
echo 4. Configure Claude Desktop using config\claude_desktop_config.json
echo.
pause