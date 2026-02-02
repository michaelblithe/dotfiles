---
name: teach
description: Explain concepts in an ADHD-friendly way. Use when someone asks "explain", "what is", "how does X work", "teach me", or wants to understand a concept. Delivers concise, focused explanations with examples and diagrams. No tangents, no fluff, respects that focus is a limited resource.
---

# Teach Skill

Explain concepts for someone with ADHD: concise, direct, example-driven.

## Core Rules

1. **Respect focus as a resource** — Every sentence must earn its place
2. **No tangents** — Answer exactly what was asked, nothing more
3. **Examples over explanations** — Show, don't tell
4. **One concept at a time** — Layer complexity only if asked
5. **End clean** — No "let me know if you have questions" padding

## Response Structure

### 1. One-Liner (Required)
What is it in ≤15 words?

### 2. Why It Exists (Required)
What problem does it solve? 1-2 sentences max.

### 3. Mental Model (Required)
Analogy or diagram. Pick one:

**ASCII diagram** — for relationships, flows, hierarchies:
```
[Thing A] --does--> [Thing B] --produces--> [Result]
```

**Analogy** — for abstract concepts:
> It's like [familiar thing]. [One sentence connecting them.]

### 4. Example (Required)
Minimal, working code or concrete instance. Strip to essentials:

```
# BAD: 50 lines showing every option
# GOOD: 5-10 lines showing the core pattern
```

### 5. Gotcha (If relevant)
One common trap. Format: ⚠️ **[Trap]**: [Why it bites you]

### 6. Joke (Optional)
Only if it lands naturally. Don't force it.

## Formatting Rules

- **Bold** key terms on first use
- Use `code` for technical names
- Bullet points for lists of 3+ items
- No headers beyond what's needed
- No "In conclusion" or "To summarize"
- No offering to explain more — they'll ask if they want it

## Source Priority

Before explaining, assess your confidence:

| Confidence | Action |
|------------|--------|
| High (well-documented, stable concept) | Explain from knowledge |
| Medium (newer tech, version-specific) | Check Context7 MCP for docs |
| Low (obscure, rapidly changing) | Web search first |

Signs you should search:
- Released in last 2 years
- User mentions specific version
- You're uncertain about current API/syntax
- Niche tool with small community

## Example Response

**User**: "Explain NixOS overlays to me"

---

**One-liner**: Overlays let you modify or add packages to nixpkgs without forking it.

**Why it exists**: You want to patch a package, use a newer version, or add your own — but you don't want to maintain a fork of all 80,000+ packages.

**Mental model**:
```
nixpkgs (base)
    ↓
overlay 1 (patches vim)
    ↓
overlay 2 (adds my-tool)
    ↓
final package set (your system uses this)
```

Think of it like Photoshop layers — each overlay sits on top, and you see the combined result.

**Example**:
```nix
# In ~/.config/nixpkgs/overlays/my-overlay.nix
self: super: {
  # Override existing package
  vim = super.vim.overrideAttrs (old: {
    patches = old.patches ++ [ ./my-fix.patch ];
  });
  
  # Add new package
  my-tool = self.callPackage ./my-tool.nix {};
}
```

- `self` = final combined packages (use for dependencies)
- `super` = packages before this overlay (use for overriding)

⚠️ **Gotcha**: Using `super` for dependencies creates infinite recursion. Use `self` for deps, `super` only for "the thing I'm modifying."

---

## Anti-Patterns (Don't Do These)

❌ "Before I explain X, let me give you some background on Y..."
❌ "There are several ways to think about this..."  
❌ "This is a complex topic, but I'll try to simplify..."
❌ "Let me know if you want me to go deeper on any part!"
❌ Explaining prerequisites they didn't ask about
❌ Mentioning "advanced" features unprompted
❌ History lessons unless specifically asked

## Handling Follow-ups

When they ask a follow-up:
1. Answer that specific question
2. Same format: direct, example-driven
3. Don't recap what you already said
4. Don't preemptively answer questions they didn't ask