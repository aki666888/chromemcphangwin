# Chrome MCP Windows Setup

Quick setup for Chrome MCP Server on Windows with Claude Desktop/Code integration.

## Prerequisites

1. **Node.js** - Download from https://nodejs.org/
2. **Chrome Browser**
3. **Chrome MCP Server Extension** - From Chrome Web Store or load unpacked from C:\chrome-mcp-server-0.0.6

## Quick Install

1. **Run the setup script:**
   ```batch
   setup-chrome-mcp-windows.bat
   ```
   This will:
   - Install mcp-chrome-bridge globally
   - Configure native messaging
   - Register with Chrome

2. **Configure Claude Desktop:**
   - Copy `config\claude_desktop_config.json` to `%APPDATA%\Claude\claude_desktop_config.json`
   - Or manually add the configuration to your existing config
   - Restart Claude Desktop

3. **Connect:**
   - Make sure Chrome is running
   - Click the Chrome MCP extension icon
   - Click "Connect" - you should see "Connected" status
   - The HTTP server runs on port 12306

## Client Configuration

### Claude Desktop (STDIO method - Required)
```json
{
  "mcpServers": {
    "chrome-mcp-stdio": {
      "command": "node",
      "args": [
        "C:\\Users\\YOUR_USERNAME\\AppData\\Roaming\\npm\\node_modules\\mcp-chrome-bridge\\dist\\mcp\\mcp-server-stdio.js"
      ]
    }
  }
}
```
Replace `YOUR_USERNAME` with your Windows username.

### Claude Code (Streamable HTTP - Recommended)
```json
{
  "mcpServers": {
    "chrome-mcp-server": {
      "type": "streamableHttp",
      "url": "http://127.0.0.1:12306/mcp"
    }
  }
}
```

## Troubleshooting

### "NATIVE_DISCONNECTED" Error
- Make sure Node.js is installed on Windows (not just WSL)
- Check that your Chrome extension ID matches the one in the manifest
- Run `test-connection.bat` to diagnose issues

### Claude Desktop Shows Error
- Make sure the Chrome extension shows "Connected" status first
- Check that the path in claude_desktop_config.json is correct
- Verify mcp-chrome-bridge is installed: `npm list -g mcp-chrome-bridge`

### Port 12306 Not Accessible
- Check Windows Firewall settings
- Make sure no other application is using port 12306
- Try disconnecting and reconnecting the extension

## Configuration Files

- **Native Host Manifest**: `%USERPROFILE%\.config\chrome-native-messaging-hosts\com.chromemcp.nativehost.json`
- **Claude Desktop Config**: `%APPDATA%\Claude\claude_desktop_config.json`
- **Chrome Extension**: Shows connection status and port number

## Manual Setup

If the automatic setup doesn't work:

1. Install mcp-chrome-bridge:
   ```
   npm install -g mcp-chrome-bridge
   ```

2. Find your installation path:
   ```
   npm list -g mcp-chrome-bridge
   ```

3. Get your Chrome extension ID from chrome://extensions

4. Register with Chrome:
   ```
   node "%APPDATA%\npm\node_modules\mcp-chrome-bridge\dist\cli.js" register
   ```

5. Enter your extension ID when prompted

6. Update Claude Desktop config with your path

7. Restart Chrome and Claude Desktop