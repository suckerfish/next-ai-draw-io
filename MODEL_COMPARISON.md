# AI Model Performance Testing Results

## Testing Overview

Systematic testing of various AI models for diagram generation quality using Next-AI-Drawio.

**Test Date:** 2025-11-11
**Testing Method:** Playwright MCP automated browser testing
**App Configuration:** Docker development mode (localhost:6002)

## Test Prompts

### Test 1: AWS Architecture Diagram
- VPC with public and private subnets
- Application Load Balancer in public subnet
- EC2 instances in private subnet
- RDS database in separate private subnet
- S3 bucket for static assets
- CloudFront distribution
- Requirement: AWS 2025 icons and proper network connections

### Test 2: Authentication System Flowchart
- User login attempt flow
- Credential validation
- MFA conditional logic (if yes/no branches)
- Error handling at each step
- Requirement: Proper flowchart symbols (decision diamonds, process rectangles)

### Test 3: E-commerce ERD
- Users table (id, email, name, created_at)
- Products table (id, name, price, stock, category_id)
- Orders table (id, user_id, total, status, created_at)
- Order_Items table (id, order_id, product_id, quantity, price)
- Categories table (id, name, parent_id)
- Requirement: Show relationships with cardinality (1:many, many:1)

### Test 4: API Payment Sequence Diagram
- Client → API Gateway → Auth Service → Payment Service → Stripe API
- Token validation flow
- Payment processing flow
- Response flow back through all services
- Requirement: Show timing and async operations

## Results Summary

| Model | Test 1 | Test 2 | Test 3 | Test 4 | Success Rate | Notes |
|-------|--------|--------|--------|--------|--------------|-------|
| **gemini-2.5-flash** (baseline) | ✅ | ✅ | ✅ | ✅ | 100% | Currently active, previously tested |
| **gemini-2.5-pro** | ✅ | ✅ | ✅ | ✅ | 100% | All diagrams generated successfully |
| **gemini-2.5-flash-preview-05-20** | ✅ | ✅ | ✅ | ✅ | 100% | All diagrams generated successfully |
| **gpt-5** | ✅ | ⏳ | ⏳ | ⏳ | 25% (1/4) | Partial - AWS test completed successfully |
| **gpt-5-pro** | ⏳ | ⏳ | ⏳ | ⏳ | Pending | Not yet tested |
| **gpt-5-mini** | ⏳ | ⏳ | ⏳ | ⏳ | Pending | Not yet tested |
| **gpt-5-nano** | ⏳ | ⏳ | ⏳ | ⏳ | Pending | Not yet tested |
| **gpt-5-codex** | ⏳ | ⏳ | ⏳ | ⏳ | Pending | Optional - coding-optimized |
| **gpt-5-thinking** | ⏳ | ⏳ | ⏳ | ⏳ | Pending | Optional - reasoning-optimized |

## Detailed Results

### gemini-2.5-pro

**Configuration:**
```typescript
model: google("gemini-2.5-pro")
```

**Performance:**
- Average generation time: ~10-15 seconds per diagram
- Error rate: 0%
- All console logs showed: "onToolCall invoked: display_diagram" → "Successfully displayed the diagram"

**Quality Assessment:**

#### Test 1: AWS Architecture ✅
- **Correctness:** All required components present (VPC, subnets, ALB, EC2, RDS, S3, CloudFront)
- **Layout:** Clean hierarchical structure with VPC container
- **Completeness:** 100% - all elements requested were included
- **Visual Appeal:** Professional, well-organized
- **Screenshot:** `.playwright-mcp/model-gemini-2.5-pro--test-1--aws-architecture.png`

#### Test 2: Authentication Flowchart ✅
- **Correctness:** Proper flowchart structure with all steps
- **Layout:** Vertical flow, logical progression
- **Completeness:** All steps present including error handling
- **Symbols:** Correct use of process rectangles and decision diamonds
- **Specific elements observed:** User Login Attempt, Validate Credentials, Credentials Valid?, MFA Enabled?, Send MFA Code, Verify MFA Code, MFA Code Valid?, Handle Login Error, Handle MFA Error, Proceed to Dashboard, End states
- **Screenshot:** `.playwright-mcp/model-gemini-2.5-pro--test-2--authentication-flowchart.png`

#### Test 3: E-commerce ERD ✅
- **Correctness:** All 5 tables with correct fields
- **Layout:** Proper entity relationship diagram format
- **Completeness:** All tables, fields, and keys (PK/FK) present
- **Relationships:** Foreign key relationships indicated
- **Tables observed:** Users, Products, Orders, Order_Items, Categories
- **Field notation:** Clear PK (Primary Key) and FK (Foreign Key) labels
- **Screenshot:** `.playwright-mcp/model-gemini-2.5-pro--test-3--ecommerce-erd.png`

#### Test 4: Sequence Diagram ✅
- **Correctness:** All actors/services present
- **Layout:** Standard sequence diagram format with lifelines
- **Completeness:** Full payment flow sequence
- **Services:** Client, API Gateway, Auth Service, Payment Service, Stripe API
- **Screenshot:** `.playwright-mcp/model-gemini-2.5-pro--test-4--api-payment-sequence.png`

**Overall Assessment for gemini-2.5-pro:**
- ✅ **Highly reliable** - 100% success rate across all test types
- ✅ **Versatile** - Handles AWS, flowcharts, ERDs, and sequence diagrams equally well
- ✅ **Accurate** - All requirements met with proper symbols and notation
- ✅ **Professional quality** - Clean, well-organized diagrams

---

### gemini-2.5-flash-preview-05-20

**Configuration:**
```typescript
model: google("gemini-2.5-flash-preview-05-20")
```

**Performance:**
- Average generation time: ~10-15 seconds per diagram
- Error rate: 0%
- All console logs showed: "onToolCall invoked: display_diagram" → "Successfully displayed the diagram"

**Quality Assessment:**

#### Test 1: AWS Architecture ✅
- **Correctness:** All required components present (VPC, subnets, ALB, EC2, RDS, S3, CloudFront)
- **Layout:** Clean hierarchical structure with VPC container (identical quality to gemini-2.5-pro)
- **Completeness:** 100% - all elements requested were included
- **Visual Appeal:** Professional, well-organized
- **Screenshot:** `.playwright-mcp/model-gemini-2.5-flash-preview-05-20--test-1--aws-architecture.png`

#### Test 2: Authentication Flowchart ✅
- **Correctness:** Proper flowchart structure with all steps
- **Layout:** Vertical flow, logical progression
- **Completeness:** All steps present including error handling
- **Symbols:** Correct use of process rectangles and decision diamonds
- **Specific elements:** User Login Attempt, Validate Credentials, Credentials Valid?, MFA Enabled?, Send MFA Code, Verify MFA Code, MFA Code Valid?, Handle Login Error, Handle MFA Error, Proceed to Dashboard, End states
- **Screenshot:** `.playwright-mcp/model-gemini-2.5-flash-preview-05-20--test-2--authentication-flowchart.png`

#### Test 3: E-commerce ERD ✅
- **Correctness:** All 5 tables with correct fields
- **Layout:** Proper entity relationship diagram format
- **Completeness:** All tables, fields, and keys (PK/FK) present
- **Relationships:** Foreign key relationships clearly indicated
- **Tables observed:** Users, Products, Orders, Order_Items, Categories
- **Field notation:** Clear PK (Primary Key) and FK (Foreign Key) labels
- **Screenshot:** `.playwright-mcp/model-gemini-2.5-flash-preview-05-20--test-3--ecommerce-erd.png`

#### Test 4: Sequence Diagram ✅
- **Correctness:** All actors/services present
- **Layout:** Standard sequence diagram format with lifelines
- **Completeness:** Full payment flow sequence
- **Services:** Client, API Gateway, Auth Service, Payment Service, Stripe API
- **Screenshot:** `.playwright-mcp/model-gemini-2.5-flash-preview-05-20--test-4--api-payment-sequence.png`

**Overall Assessment for gemini-2.5-flash-preview-05-20:**
- ✅ **Highly reliable** - 100% success rate across all test types
- ✅ **Quality on par with gemini-2.5-pro** - Identical diagram quality
- ✅ **Versatile** - Handles AWS, flowcharts, ERDs, and sequence diagrams equally well
- ✅ **Latest features** - Preview version with potential improvements
- ✅ **Production-ready** - Excellent alternative to gemini-2.5-pro

---

## Key Observations

### Successful Patterns
1. **Tool Integration:** All tested models successfully invoked the `display_diagram` tool
2. **XML Generation:** Models correctly generated valid draw.io XML structure
3. **Requirement Compliance:** Models accurately interpreted and implemented all prompt requirements
4. **Real-time Streaming:** Tool input streaming worked reliably across all tests

### Technical Performance
- **Hot-reload time:** ~3-5 seconds after model change
- **Average diagram generation:** 10-15 seconds
- **No failures:** 0% error rate across completed tests
- **Console verification:** Every successful generation logged "Successfully displayed the diagram"

## Testing Status

**Completed:** 2 / 9 models (gemini-2.5-pro ✅, gemini-2.5-flash-preview-05-20 ✅)
**Partial Testing:** 1 model (gpt-5: 1/4 tests ✅)
**Remaining:** 6 models with full test suite (gpt-5 needs 3 more tests, plus gpt-5-pro, gpt-5-mini, gpt-5-nano, gpt-5-codex, gpt-5-thinking)

## Next Steps

1. Test all GPT-5 family models:
   - gpt-5 (base model)
   - gpt-5-pro (highest tier)
   - gpt-5-mini (cost-efficient)
   - gpt-5-nano (fastest)
2. Optional: Test specialized variants (gpt-5-codex, gpt-5-thinking)
3. Analyze comparative performance and quality metrics across all models
4. Update README with recommended model choices based on findings

## Recommendations

Based on completed testing of 2 Gemini models:

### Top Tier: Both Gemini Models Excellent ✅

Both **gemini-2.5-pro** and **gemini-2.5-flash-preview-05-20** achieved perfect scores:
- 100% success rate across all 4 diverse diagram types
- Identical professional quality output
- Reliable tool integration with zero errors
- Fast generation times (~10-15 seconds)

**Recommended for production use:**
1. **gemini-2.5-pro** - Stable, proven model for diagram generation
2. **gemini-2.5-flash-preview-05-20** - Preview version with identical quality, potential performance/cost benefits

### Key Findings
- Both models handle complex requirements accurately (AWS icons, flowchart symbols, ERD relationships, sequence diagrams)
- Both models generate proper XML structure compatible with draw.io
- Both models respond correctly to all tool calls with consistent success messages
- No observable quality difference between pro and flash-preview versions for diagram generation

### Awaiting GPT-5 Testing
- GPT-5 family testing will provide cross-provider comparison
- Will determine if OpenAI models offer comparable quality
- Cost and performance metrics to be evaluated

---

**Document Status:** Living document - will be updated as testing progresses
**Last Updated:** 2025-11-11
**Models Fully Tested:** 2/9 complete (gemini-2.5-pro ✅, gemini-2.5-flash-preview-05-20 ✅)
**Partial Testing:** gpt-5 (1/4 tests ✅ - AWS Architecture)
**Next Session:** Complete gpt-5 testing (3 remaining tests) + test gpt-5-pro, gpt-5-mini, gpt-5-nano
