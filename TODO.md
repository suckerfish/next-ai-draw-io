# TODO: Model Performance Testing with Playwright MCP

## Objective
Systematically test AI models for diagram generation quality. Capture screenshots for later visual evaluation. **NO EVALUATION DURING CAPTURE** - only take screenshots with proper naming.

## Test Models

### Core Models (Required Testing)
1. **gemini-2.5-flash** - Baseline model
2. **gemini-2.5-pro** - Higher quality Gemini
3. **gemini-2.5-flash-preview-05-20** - Latest preview version
4. **gpt-5** - Base GPT-5 model
5. **gpt-5-pro** - Highest tier GPT-5
6. **gpt-5-mini** - Cost-efficient GPT-5

### Optional Models
7. **gpt-5-nano** - Smallest/fastest GPT-5
8. **gpt-5-codex** - Coding-optimized
9. **gpt-5-thinking** - Reasoning-optimized

## Test Prompts (2 Tests Only)

### Test 1: Authentication Flowchart
```
Create a flowchart for a user authentication system:
- User login attempt
- Validate credentials
- Check if MFA is enabled
- If yes: send MFA code, verify code
- If no: proceed to dashboard
- Handle errors at each step
Use proper flowchart symbols (decision diamonds, process rectangles, etc.)
```

### Test 2: E-commerce ERD
```
Create an entity relationship diagram for an e-commerce system:
- Users table (id, email, name, created_at)
- Products table (id, name, price, stock, category_id)
- Orders table (id, user_id, total, status, created_at)
- Order_Items table (id, order_id, product_id, quantity, price)
- Categories table (id, name, parent_id)
Show relationships with cardinality (1:many, many:1, etc.)
```

## Testing Procedure

### For Each Model:

1. **Update Model Configuration**
   - Edit `app/api/chat/route.ts` line 139
   - Set: `model: google("model-name")` or `model: openai("model-name")`
   - Wait 5 seconds for hot-reload

2. **Navigate to App**
   ```javascript
   mcp__playwright__browser_navigate("http://localhost:6002")
   ```

3. **Run Test 1: Flowchart**
   - Click chat input
   - Type the flowchart prompt (see above)
   - Press Meta+Enter
   - Wait 15 seconds for generation
   - Verify console shows: "Successfully displayed the diagram"
   - Take screenshot: `model-{model-name}--test-1--flowchart.png`
   - **IMPORTANT: Update TodoWrite to mark test 1 complete for this model**

4. **Run Test 2: ERD**
   - Click chat input
   - Type the ERD prompt (see above)
   - Press Meta+Enter
   - Wait 15 seconds for generation
   - Verify console shows: "Successfully displayed the diagram"
   - Take screenshot: `model-{model-name}--test-2--erd.png`
   - **IMPORTANT: Update TodoWrite to mark test 2 complete for this model**

## Screenshot Naming Convention

**CRITICAL: Use exact naming format**

```
model-{model-name}--test-{test-number}--{test-name}.png
```

### Examples:
- `model-gemini-2.5-flash--test-1--flowchart.png`
- `model-gemini-2.5-flash--test-2--erd.png`
- `model-gpt-5-pro--test-1--flowchart.png`
- `model-gpt-5-pro--test-2--erd.png`

### Model Name Mappings:
- `gemini-2.5-flash` → `model-gemini-2.5-flash--`
- `gemini-2.5-pro` → `model-gemini-2.5-pro--`
- `gemini-2.5-flash-preview-05-20` → `model-gemini-2.5-flash-preview-05-20--`
- `gpt-5` → `model-gpt-5--`
- `gpt-5-pro` → `model-gpt-5-pro--`
- `gpt-5-mini` → `model-gpt-5-mini--`
- `gpt-5-nano` → `model-gpt-5-nano--`

## Model Configuration Reference

```typescript
// app/api/chat/route.ts line 139

// Google Gemini Models
model: google("gemini-2.5-flash"),
model: google("gemini-2.5-pro"),
model: google("gemini-2.5-flash-preview-05-20"),

// OpenAI GPT-5 Models
model: openai("gpt-5"),
model: openai("gpt-5-pro"),
model: openai("gpt-5-mini"),
model: openai("gpt-5-nano"),
model: openai("gpt-5-codex"),      // Optional
model: openai("gpt-5-thinking"),   // Optional
```

## Testing Progress

| Model | Test 1 (Flowchart) | Test 2 (ERD) | Status |
|-------|-------------------|--------------|--------|
| gemini-2.5-flash | ⏳ | ⏳ | Not Started |
| gemini-2.5-pro | ⏳ | ⏳ | Not Started |
| gemini-2.5-flash-preview-05-20 | ⏳ | ⏳ | Not Started |
| gpt-5 | ⏳ | ⏳ | Not Started |
| gpt-5-pro | ⏳ | ⏳ | Not Started |
| gpt-5-mini | ⏳ | ⏳ | Not Started |
| gpt-5-nano | ⏳ | ⏳ | Optional |
| gpt-5-codex | ⏳ | ⏳ | Optional |
| gpt-5-thinking | ⏳ | ⏳ | Optional |

## IMPORTANT REMINDERS

### ✅ DO:
- **CRITICAL: Update TodoWrite IMMEDIATELY after EACH screenshot is taken (not in batches, not later, RIGHT NOW)**
- **CRITICAL: Mark todo as in_progress BEFORE starting test, completed IMMEDIATELY after screenshot**
- Use exact screenshot naming format
- Wait 15 seconds for diagram generation
- Verify "Successfully displayed the diagram" in console
- Keep Docker running throughout all testing

### ❌ DO NOT:
- Do NOT evaluate diagram quality during testing
- Do NOT compare screenshots during testing
- Do NOT make quality assessments during testing
- Do NOT skip TodoWrite updates

## After All Testing

Visual evaluation will be done in a SEPARATE session after all screenshots are captured. This session is ONLY for systematic screenshot capture with proper naming.

---

**Status:** Ready for systematic testing
**Screenshot Directory:** `.playwright-mcp/`
**Tests per Model:** 2 (Flowchart + ERD)
**Total Screenshots Expected:** 12 (6 models × 2 tests) or 18 (9 models × 2 tests with optionals)
