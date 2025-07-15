# Chrome MCP Windows Setup

Complete setup guide for Chrome MCP Server on Windows with Claude Desktop/Code integration. Transform your browser into an AI-controlled automation tool.

## What is Chrome MCP?

Chrome MCP Server is a Chrome extension that enables AI assistants like Claude to:
- **Control your browser** - Navigate, click, fill forms, scroll
- **Capture screenshots** - Full page or visible area  
- **Analyze web content** - Extract text, analyze page structure
- **Monitor network** - Capture requests and responses
- **Manage bookmarks** - Add, search, delete bookmarks
- **Search across tabs** - Semantic search across all open browser tabs
- **Preserve login states** - Uses your existing browser sessions

## Prerequisites

1. **Node.js ≥ 18.19.0** - Download from https://nodejs.org/
2. **Chrome Browser**  
3. **Chrome MCP Server Extension** - Download from https://github.com/hangwin/mcp-chrome/releases

## Quick Install

### 1. Run the Setup Script
```batch
setup-chrome-mcp-windows.bat
```
This will:
- Install mcp-chrome-bridge globally
- Configure native messaging  
- Register with Chrome
- Ask for your Chrome extension ID

### 2. Load Chrome Extension
1. Download extension from GitHub releases
2. Open Chrome → `chrome://extensions/`
3. Enable "Developer mode" (top right)
4. Click "Load unpacked" → Select extension folder
5. **Copy the Extension ID** (e.g., `hbdgbgagpkpjffpklnamcljpakneikee`)

### 3. Register Extension  
```bash
mcp-chrome-bridge register
```
Enter your Extension ID when prompted.

### 4. Configure Claude Desktop
Copy `config\claude_desktop_config.json` to `%APPDATA%\Claude\claude_desktop_config.json`

**WORKING CONFIGURATION:**
```json
{
  "mcpServers": {
    "chrome-mcp-server": {
      "command": "node",
      "args": [
        "C:\\Users\\info0\\AppData\\Roaming\\npm\\node_modules\\mcp-chrome-bridge\\dist\\mcp\\mcp-server-stdio.js"
      ]
    }
  }
}
```

### 5. Connect and Test
1. Restart Claude Desktop completely
2. Click Chrome MCP extension → "Connect"  
3. Should show "Connected" status and port 12306
4. Test in Claude: "Take a screenshot of this page"

## Client Configuration

### Claude Desktop (STDIO Method - Tested ✅)
```json
{
  "mcpServers": {
    "chrome-mcp-server": {
      "command": "node", 
      "args": [
        "C:\\Users\\YOUR_USERNAME\\AppData\\Roaming\\npm\\node_modules\\mcp-chrome-bridge\\dist\\mcp\\mcp-server-stdio.js"
      ]
    }
  }
}
```

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

## Available Tools (20+)

### Browser Control
- **Navigate**: Go to URLs, refresh, back/forward
- **Screenshot**: Capture full page or visible area
- **Scroll**: Scroll to elements or by amount
- **Window Management**: Resize, move, minimize

### Web Interaction  
- **Click Elements**: Click buttons, links, any element
- **Fill Forms**: Enter text in input fields
- **Extract Content**: Get text, HTML, page structure
- **Element Analysis**: Find and analyze page elements

### Advanced Features
- **Network Monitoring**: Capture HTTP requests/responses
- **Bookmark Management**: Add, search, delete bookmarks
- **Tab Management**: Switch, close, open new tabs
- **Semantic Search**: Search content across all open tabs

## Example Usage

```
"Take a screenshot of this page"
"Navigate to google.com and search for AI news"
"Click the login button"
"Fill in the email field with test@example.com"
"Extract all the text from this page"
"Search for 'cryptocurrency' across all my open tabs"
"Add this page to bookmarks"
"Capture network requests when I click submit"
```

## Troubleshooting

### ⚠️ "NATIVE_DISCONNECTED" Error
**Most Common Issue:** Chrome extension can't talk to the bridge
- ✅ **Install Node.js on Windows** (not WSL!)
- ✅ **Install mcp-chrome-bridge globally:** `npm install -g mcp-chrome-bridge`
- ✅ **Register with correct Extension ID:** `mcp-chrome-bridge register`
- ✅ **Restart Chrome completely** after registration

### ⚠️ Extension Shows "Disconnected"
- Check Extension ID matches registered one
- Verify native messaging host is registered  
- Run `test-connection.bat` for diagnosis
- Try uninstalling/reinstalling mcp-chrome-bridge

### ⚠️ Claude Desktop Config Errors
- Use **STDIO method** for Claude Desktop (not streamableHttp)
- Check file path exists: `C:\\Users\\YOUR_USERNAME\\AppData\\Roaming\\npm\\node_modules\\mcp-chrome-bridge\\`
- Replace `YOUR_USERNAME` with actual Windows username
- Restart Claude Desktop after config changes

### ⚠️ Port 12306 Issues
- Check Windows Firewall settings
- Make sure no other app uses port 12306  
- Extension shows port number when connected
- Try disconnecting/reconnecting extension

### 🐧 WSL Users Important Note
- **Install everything on Windows**, not WSL
- Chrome on Windows cannot access WSL native messaging
- Use Windows Command Prompt for all npm commands

## File Locations

- **Extension**: Load unpacked from downloaded folder
- **Native Host Manifest**: `%USERPROFILE%\.config\chrome-native-messaging-hosts\com.chromemcp.nativehost.json`
- **Claude Desktop Config**: `%APPDATA%\Claude\claude_desktop_config.json`
- **MCP Bridge**: `%APPDATA%\npm\node_modules\mcp-chrome-bridge\`

## Advanced Integration

### Combined with Other MCP Servers
```json
{
  "mcpServers": {
    "chrome-mcp-server": {
      "command": "node",
      "args": ["C:\\path\\to\\mcp-server-stdio.js"]
    },
    "pharmacare-form": {
      "command": "python", 
      "args": ["C:\\mcp-servers\\pharmacare-form\\mcp_server_simple.py"]
    },
    "openrpc": {
      "command": "npx",
      "args": ["-y", "openrpc-mcp-server"]
    }
  }
}
```

### Workflow Automation
Chrome MCP excels at complex workflows:
1. **Navigate** to a website
2. **Screenshot** to analyze layout  
3. **Extract** specific information
4. **Fill forms** with extracted data
5. **Monitor network** for API calls
6. **Search tabs** for related information

## Security & Privacy

- ✅ **Fully Local**: No data sent to external servers
- ✅ **User Control**: Extension requires explicit permission
- ✅ **Session Preservation**: Uses existing browser login states
- ✅ **Open Source**: MIT licensed, code is auditable

## Updates

```bash
# Update the bridge
npm update -g mcp-chrome-bridge

# Update extension  
# Download latest from GitHub releases
# Reload in chrome://extensions

# Restart Claude Desktop/Code
```

## Support & Links

- **Extension Repository**: https://github.com/hangwin/mcp-chrome  
- **Issues**: https://github.com/hangwin/mcp-chrome/issues
- **This Setup Repo**: https://github.com/aki666888/chromemcphangwin
- **Related**: PharmaCare Form Filler - https://github.com/aki666888/pdfmcp

## Quick Setup Checklist

- [ ] Install Node.js ≥ 18.19.0
- [ ] Download Chrome MCP extension
- [ ] Run `npm install -g mcp-chrome-bridge`
- [ ] Load unpacked extension in Chrome
- [ ] Copy Extension ID  
- [ ] Run `mcp-chrome-bridge register`
- [ ] Update Claude Desktop config
- [ ] Restart Chrome and Claude Desktop
- [ ] Click "Connect" in extension
- [ ] Test with "Take a screenshot"

## Working Configuration (Tested)

This exact config is confirmed working:
```json
{
  "mcpServers": {
    "chrome-mcp-server": {
      "command": "node",
      "args": [
        "C:\\Users\\info0\\AppData\\Roaming\\npm\\node_modules\\mcp-chrome-bridge\\dist\\mcp\\mcp-server-stdio.js"
      ]
    }
  }
}
```

Extension ID: `hbdgbgagpkpjffpklnamcljpakneikee`
Status: ✅ Connected on port 12306