# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Next AI Draw.io is a Next.js application that integrates AI capabilities with draw.io diagrams. Users can create, modify, and enhance diagrams through natural language commands. The app uses AI to generate or edit draw.io XML that renders as diagrams.

## Development Commands

### Docker (Primary Method)
- `npm run docker:up` - Start development server with hot-reload (port 6002)
- `npm run docker:down` - Stop and remove containers
- `npm run docker:build` - Rebuild Docker image after dependency changes
- `npm run docker:prod` - Run in production mode (port 6001)

### Local Development (Alternative)
- `npm run dev` - Start development server on port 6002 (with turbopack)
- `npm run build` - Build for production
- `npm start` - Start production server on port 6001
- `npm run lint` - Run Next.js linter

## Environment Setup

Create a `.env.local` file (use `env.example` as template). At minimum, one AI provider API key is required:
- `GOOGLE_GENERATIVE_AI_API_KEY` - For Google Gemini models
- `OPENAI_API_KEY` - For OpenAI models
- `OPENROUTER_API_KEY` - For OpenRouter models
- `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION` - For AWS Bedrock models

## Docker Setup

Simplified single-image Docker setup optimized for solo development with Docker as primary workflow.

### Quick Start

**First time setup:**
```bash
cp env.example .env.local
# Edit .env.local with your API keys
npm run docker:build
```

**Development** (default, with hot-reload):
```bash
npm run docker:up
```
Access at http://localhost:6002. Code changes auto-reload.

**Production mode:**
```bash
npm run docker:prod
```
Access at http://localhost:6001.

### How It Works

- **Single Dockerfile**: One production-ready image that works for both dev and prod
- **Smart docker-compose.yml**:
  - Defaults to development mode with hot-reload via volume mounts
  - Switch to production by setting `NODE_ENV=production`
  - Automatically loads `.env.local` for API keys
- **.dockerignore**: Excludes build artifacts and unnecessary files
- **next.config.ts**: Configured with `output: 'standalone'` for optimized builds

### Development vs Production

The same image runs in different modes:
- **Development**: Volume mounts enabled, runs `npm run dev`, hot-reload active
- **Production**: Same image, different command (`npm start`), optimized build

### When to Rebuild

Rebuild the image when:
- Adding/removing npm packages
- Changing Dockerfile or docker-compose.yml
- First time setup

Code changes don't require rebuild (hot-reload handles it).

## Architecture

### AI Chat & Diagram Generation Flow

1. **Chat API Route** (`app/api/chat/route.ts`): Core AI integration
   - Receives user messages and current diagram XML state
   - Uses AI SDK with multiple provider support (Bedrock, Google, OpenAI, OpenRouter)
   - Provides two tools to the AI:
     - `display_diagram`: Generate new diagram from scratch (returns XML `<root>` content)
     - `edit_diagram`: Make targeted edits to existing diagram (search/replace pairs)
   - Currently configured to use AWS Bedrock Claude Sonnet 4.5 with fine-grained tool streaming

2. **Diagram Context** (`contexts/diagram-context.tsx`): Central state management
   - Manages diagram XML state and history
   - Provides `loadDiagram()` to update draw.io embed
   - `handleExport()` triggers diagram export to XML+SVG format
   - `handleDiagramExport()` processes exported data and updates state
   - Maintains version history for undo/restore functionality

3. **Chat Panel** (`components/chat-panel.tsx`): User interface
   - Uses `@ai-sdk/react` `useChat()` hook for AI interactions
   - Handles tool calls from AI:
     - `display_diagram`: Streams XML updates in real-time to draw.io
     - `edit_diagram`: Fetches current XML, applies edits via `replaceXMLParts()`, reloads diagram
   - On message submit, fetches current diagram XML and sends to AI with user input
   - Supports image attachments (converted to data URLs)

### XML Processing Utilities (`lib/utils.ts`)

- `formatXML()`: Pretty-print XML with proper indentation
- `replaceNodes()`: Replace diagram nodes in full draw.io XML structure
- `replaceXMLParts()`: Apply search/replace edits to XML (used by `edit_diagram` tool)
  - Three-phase matching: exact line match → trimmed line match → substring match
  - Formats XML before processing for consistency
  - Throws error if search pattern not found (AI should fall back to `display_diagram`)
- `extractDiagramXML()`: Decode compressed XML from draw.io SVG export (base64 + pako inflate)
- `convertToLegalXml()`: Clean up incomplete/streamed XML by closing open tags and removing incomplete mxCell elements

### Draw.io XML Schema

See `app/api/chat/xml_guide.md` for comprehensive draw.io XML reference including:
- Structure: `<mxfile>` → `<diagram>` → `<mxGraphModel>` → `<root>` → `<mxCell>` elements
- Cell types: vertices (shapes) and edges (connectors)
- Geometry positioning (x, y, width, height)
- Style attributes for shapes, colors, connectors
- Special patterns: grouping, swimlanes, tables, layers

The AI is instructed to:
- Keep diagrams within viewport (x: 0-800, y: 0-600, max container: 700x550)
- Use AWS 2025 icons for AWS architecture diagrams
- Choose `display_diagram` for major changes, `edit_diagram` for targeted updates
- Fall back to `display_diagram` if `edit_diagram` search patterns fail

### Component Structure

- `components/chat-input.tsx`: Text input with file upload support
- `components/chat-message-display.tsx`: Renders messages and handles streaming XML display
- `components/history-dialog.tsx`: View/restore previous diagram versions
- `components/file-preview-list.tsx`: Show attached images
- `app/page.tsx`: Main page with split layout (diagram viewer + chat panel)

## Key Technical Details

- **Streaming XML Updates**: The app supports streaming partial XML as the AI generates it, with `convertToLegalXml()` ensuring valid XML during streaming
- **Tool Input Streaming**: Uses Bedrock's `fine-grained-tool-streaming-2025-05-14` beta for incremental tool input updates
- **React Drawio**: Uses `react-drawio` package to embed draw.io editor as iframe
- **AI SDK**: Leverages Vercel AI SDK (`ai` package) for unified multi-provider AI interactions
