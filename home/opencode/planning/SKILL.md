---
name: plan
description: Plan and break down technical work into implementable tasks. Use when someone provides a design doc, requirements, or says "plan", "break down", "implement this", or shares a feature specification. Reviews requirements, checks existing code, validates against external docs, identifies gaps, then produces detailed task breakdown for simpler LLMs to execute.
---

# Planning Skill

Turn high-level requirements into detailed, LLM-executable task breakdowns.

## Process

Execute these phases in order. Do not skip phases.

### Phase 1: Requirements Review

Read the provided design/requirements and answer:

1. **What's NOT specified?** List ambiguities, missing details, unstated assumptions
2. **What might be incorrect?** Conflicts, impossible requirements, misunderstandings
3. **What needs clarification?** Questions for the user before proceeding

Format findings as:

```
## Requirements Review

### Missing Details
- [ ] [Thing not specified] — [Why it matters]

### Potential Issues  
- [ ] [Concern] — [Why it's a problem]

### Questions
1. [Question]?
```

**STOP after Phase 1.** Present findings and wait for user confirmation before proceeding.

### Phase 2: Codebase Discovery

Search the repo for existing patterns:

```bash
# Find related code
rg -l "keyword" --type nix  # adjust type as needed
fd -e nix "related-name"

# Check existing module structure
ls -la modules/ services/ 

# Find similar implementations to follow
rg "similar-pattern" -C 5
```

Document findings:
- Existing modules to extend or follow
- Patterns already established in the codebase
- Files that will need modification
- Conventions to maintain

### Phase 3: External Reference Check

If helpful links provided, fetch and extract relevant details:
- CLI flags and options
- Configuration formats
- API requirements
- Version-specific behavior

If links not provided but needed, search:
1. Context7 MCP for programming docs
2. Web search for official documentation

Record only information directly relevant to the task.

### Phase 4: Architecture Design

Create visual documentation:

**System diagram** (required):
```
┌─────────────┐     ┌─────────────┐
│ Component A │────▶│ Component B │
└─────────────┘     └─────────────┘
        │
        ▼
┌─────────────┐
│ Component C │
└─────────────┘
```

**File structure** (required):
```
path/to/feature/
├── file1.nix      # Purpose
├── file2.nix      # Purpose
└── subfolder/
    └── file3.nix  # Purpose
```

**Config examples** (if applicable):
```nix
# Show the shape of configuration users will write
{
  services.example = {
    enable = true;
    setting = "value";
  };
}
```

### Phase 5: Task Breakdown

Break into tasks sized for simple LLMs (Haiku-class). Each task must be:

- **Atomic**: One clear objective
- **Self-contained**: All context included, no "see previous task"
- **Verifiable**: Clear done condition
- **Detailed**: Exact file paths, code patterns, expected output

#### Task Template

```markdown
## Task [N]: [Short Name]

### Objective
[One sentence: what this task accomplishes]

### Context
[What the LLM needs to know — don't assume prior knowledge]

### Files to Modify/Create
- `path/to/file.ext` — [what to do to it]

### Implementation Details
[Step-by-step instructions with code snippets]

1. [Step with example code]
```nix
# Exactly what to write
```

2. [Next step]

### Expected Result
[What should exist/work when done]

### Verification
```bash
# Command to verify it worked
```

### Dependencies
- Requires: [Task N] (if any)
- Blocks: [Task N] (if any)
```

#### Task Sizing Guide

| Too Big | Right Size |
|---------|------------|
| "Create the module" | "Create module skeleton with enable option" |
| "Add configuration" | "Add port configuration option with default 6000" |
| "Set up systemd" | "Create systemd service unit file" |

Each task should take a simple LLM 1-3 tool calls to complete.

### Phase 6: Document Output

Write to `planning/<FEATURE_NAME>/`:

```
planning/<feature>/
├── README.md           # Overview, architecture, diagrams
├── TASKS.md            # Ordered task list with full details
└── REFERENCES.md       # External docs, links, snippets (if needed)
```

**README.md structure:**
```markdown
# [Feature Name]

## Overview
[2-3 sentences]

## Architecture
[Diagrams from Phase 4]

## File Structure
[Tree from Phase 4]

## Configuration Example
[How users will configure this]

## Requirements Addressed
- [x] [Requirement 1]
- [x] [Requirement 2]
```

**TASKS.md structure:**
```markdown
# Implementation Tasks

## Summary
- Total tasks: N
- Estimated complexity: [Low/Medium/High]

## Task Order
1. [Task 1 name] — [one line description]
2. [Task 2 name] — [one line description]
...

---

## Task 1: [Name]
[Full task template]

---

## Task 2: [Name]
[Full task template]
```

### Phase 7: User Review

Present the planning document and ask:
- Does the architecture look correct?
- Are any tasks missing or unclear?
- Should any tasks be split further or combined?

Make requested changes. Do not proceed to implementation until user approves.

## Rules

- **Never assume** — If something isn't specified, ask
- **Never skip discovery** — Always check existing code first
- **Never write vague tasks** — Include exact file paths, code snippets
- **Never combine concerns** — One task = one thing
- **Always verify** — Each task must have a verification step
- **Always wait for approval** — Stop at Phase 1 and Phase 7

## Anti-Patterns

❌ "Create the service module with all configuration options"
✅ Split into: skeleton → each option → systemd → secrets

❌ "See the llama.cpp documentation for flags"
✅ Include the exact flags needed in the task

❌ "Follow the existing pattern"
✅ Show the exact pattern with a code snippet

❌ Tasks that reference other tasks for context
✅ Each task is fully self-contained