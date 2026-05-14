---
name: code-search
description: Search for code examples, patterns, and implementation guidance. Use when a developer asks "how do I", "how to", "example of", "what's the pattern for", or needs to find implementation details. Searches codebase first, then dependencies, then Context7 MCP (if available), then web as a last resort. Validates answers against the project's actual language, framework, and library versions.
---

# Code Search Skill

Answer developer questions by searching multiple sources in priority order, validating against the project's actual stack.

## Search Priority

Execute searches in this order, stopping when a satisfactory answer is found:

### 1. Codebase Search (Always First)

Search the local codebase for existing examples:

```bash
# Search for keywords from the question
rg -l "keyword1" --type py  # adjust --type for language
rg -l "keyword2.*keyword3" -i
rg -C 5 "pattern" src/  # show context around matches

# Find related files
fd -e py "test" | xargs rg "keyword"  # search test files
```

Extract keywords from the user's question. For "How do I use test-containers in python to wait for a container with a specific log":
- Keywords: `testcontainers`, `wait`, `log`, `container`
- Search patterns: `wait_for`, `log_message`, `LogWaitStrategy`

### 2. Dependency Analysis

If no codebase example found, identify project dependencies:

```bash
# Python
cat requirements.txt pyproject.toml setup.py 2>/dev/null | grep -i "relevant-package"

# Node.js
cat package.json | jq '.dependencies, .devDependencies'

# Go
cat go.mod | grep "relevant-package"

# Rust
cat Cargo.toml | grep -A5 "\[dependencies\]"

# Java/Kotlin
cat build.gradle pom.xml 2>/dev/null | grep -i "relevant-package"
```

Record exact versions—answers must match these versions.

### 3. Context7 MCP (If Available)

If the Context7 MCP server is configured, query it for documentation:

```
Use the context7 resolve-library-id tool to find the library
Then use context7 get-library-docs to retrieve documentation
```

This provides version-specific documentation directly.

### 4. Web Search (Last Resort)

Only if previous sources yield no results:
- Search for: `"package-name" "version" "specific feature" example`
- Prefer official documentation, GitHub repos, and Stack Overflow
- Note: Web results may be for different versions—verify compatibility

## Validation Checklist

Before presenting the answer, verify:

| Check | Action if Failed |
|-------|------------------|
| Language match | Reject—find answer in correct language |
| Framework match | Reject—find framework-specific answer |
| Version compatible | Flag discrepancy to user |
| API still exists | Check deprecation notices |
| Sources agree | If conflict, present both with explanation |

### Handling Discrepancies

If any validation fails, STOP and report:

```
⚠️ DISCREPANCY FOUND

I found information, but there's a conflict:

**Your project**: [package] v[X.Y.Z]
**Answer source**: Documentation for v[A.B.C]

The difference matters because: [explanation]

Options:
1. [How to adapt the answer to your version]
2. [Whether upgrading is recommended]
3. [Alternative approach that works with your version]
```

## Response Format

When everything validates, present:

### Summary
One paragraph explaining the solution. Lead with what it does, not what it is.

### Code Example
```[language]
# Complete, runnable example
# Include imports
# Show the specific pattern they asked about
# Add comments for non-obvious parts
```

### Analogy
Compare to something familiar:
> Think of [concept] like [familiar thing]. Just as [familiar action], [concept] does [similar action].

Good analogies:
- Waiting for container logs → waiting for a friend to text "I'm here" before leaving
- Connection pooling → a taxi stand vs. calling a new cab each time
- Dependency injection → a restaurant kitchen that uses whatever ingredients you bring

### Gotchas

⚠️ **Resource cleanup**: [Does this need explicit cleanup? Context managers? Close methods?]

⚠️ **Threading**: [Is this thread-safe? Async considerations?]

⚠️ **Common mistakes**: [What do people typically get wrong?]

⚠️ **Performance**: [Any performance implications to know about?]

## Example Workflow

**User asks**: "How do I use test-containers in python to wait for a container with a specific log?"

**Step 1 - Codebase search**:
```bash
rg -l "testcontainers" --type py
rg "wait.*log" --type py
rg "LogWaitStrategy\|wait_for_log" --type py
```

**Step 2 - Check dependencies**:
```bash
grep -i testcontainers requirements.txt pyproject.toml 2>/dev/null
```
→ Found: `testcontainers==3.7.1`

**Step 3 - Context7** (if available):
Query for testcontainers Python docs v3.7.x

**Step 4 - Validate**:
- ✅ Language: Python
- ✅ Version: 3.7.1 docs match
- ✅ API exists in this version

**Step 5 - Present answer** with summary, code, analogy, gotchas.

## Quick Reference: Search Patterns by Question Type

| Question Type | Search Strategy |
|--------------|-----------------|
| "How do I [action]" | Search for function/method names related to action |
| "Example of [pattern]" | Search test files first—they have the best examples |
| "What's the difference" | Search both terms, compare usage in codebase |
| "Best practice for" | Check if project has style guide, then conventions in existing code |
| "Debug [problem]" | Search for error messages, exception handling |