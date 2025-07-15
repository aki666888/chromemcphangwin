@echo off
echo Chrome MCP Connection Test
echo ==========================
echo.

echo [1] Checking Node.js...
where node >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    node --version
    echo Node.js: OK
) else (
    echo Node.js: NOT FOUND - Please install from https://nodejs.org/
)

echo.
echo [2] Checking mcp-chrome-bridge...
for /f "delims=" %%i in ('npm root -g') do set NPM_ROOT=%%i
if exist "%NPM_ROOT%\mcp-chrome-bridge" (
    echo mcp-chrome-bridge: INSTALLED
) else (
    echo mcp-chrome-bridge: NOT FOUND - Run: npm install -g mcp-chrome-bridge
)

echo.
echo [3] Checking Chrome native host registration...
set MANIFEST_FILE=%USERPROFILE%\.config\chrome-native-messaging-hosts\com.chromemcp.nativehost.json
if exist "%MANIFEST_FILE%" (
    echo Native host manifest: FOUND
    echo Location: %MANIFEST_FILE%
) else (
    echo Native host manifest: NOT FOUND
)

echo.
echo [4] Checking Registry...
REG QUERY "HKCU\Software\Google\Chrome\NativeMessagingHosts\com.chromemcp.nativehost" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Registry entry: OK
) else (
    echo Registry entry: NOT FOUND
)

echo.
echo [5] Testing port 12306...
netstat -an | findstr :12306 >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Port 12306: IN USE (Chrome MCP might be running)
) else (
    echo Port 12306: FREE (Chrome MCP not running)
)

echo.
echo ==========================
echo If all checks pass but connection fails:
echo 1. Make sure Chrome extension ID in manifest matches your extension
echo 2. Restart Chrome completely
echo 3. Check Chrome DevTools console for errors
echo.
pause