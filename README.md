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
   - Install mcp-chrome-bridge
   - Configure native messaging
   - Register with Chrome

2. **Configure Claude Desktop:**
   - Copy `config\claude_desktop_config.json` to `%APPDATA%\Claude\`
   - Or manually add the configuration to your existing config

3. **Connect:**
   - Restart Chrome completely
   - Click the Chrome MCP extension icon
   - Click "Connect"
   - You should see "Connected" status

## Troubleshooting

### "NATIVE_DISCONNECTED" Error
- Make sure Node.js is installed on Windows (not just WSL)
- Check that your Chrome extension ID matches the one in the manifest
- Run `test-connection.bat` to diagnose issues

### Port 12306 Not Accessible
- Check Windows Firewall settings
- Make sure no other application is using port 12306
- Try disconnecting and reconnecting the extension

## Configuration Files

- **Native Host Manifest**: `%USERPROFILE%\.config\chrome-native-messaging-hosts\com.chromemcp.nativehost.json`
- **Claude Desktop Config**: `%APPDATA%\Claude\claude_desktop_config.json`
- **Claude Code Config**: Add to your settings

## Manual Setup

If the automatic setup doesn't work:

1. Install mcp-chrome-bridge:
   ```
   npm install -g mcp-chrome-bridge
   ```

2. Get your Chrome extension ID from chrome://extensions

3. Run:
   ```
   node "%APPDATA%\npm\node_modules\mcp-chrome-bridge\dist\cli.js" register
   ```

4. Enter your extension ID when prompted

5. Restart Chrome and connect

## Working with Claude Code

Add this to your Claude Code settings:
```json
{
  "mcpServers": {
    "chrome-mcp": {
      "type": "streamable-http",
      "url": "http://127.0.0.1:12306/mcp"
    }
  }
}
```