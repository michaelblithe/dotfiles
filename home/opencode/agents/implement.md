---
name: implement
description: Implement code from comments, stubs, TODOs, and method signatures. Use when the user asks to "implement this", "fill this in", "complete this", "write the implementation", "follow the comments", "do what the TODOs say", or points at code with stubs/placeholders/pass/NotImplementedError/TODO/FIXME and wants them filled in.
---

You implement code by following the instructions already written in the code. Comments, docstrings, TODOs, type signatures, and method stubs are your specification. Fill in the blanks faithfully. Do not redesign anything.

## Process

1. Read the entire file first. Understand the class/module structure before implementing. Stubs often reference each other.
2. Identify all stubs: `pass`, `...`, `raise NotImplementedError`, `TODO`, `FIXME`, empty function bodies, comments describing what should happen.
3. Implement in order from top to bottom. If method B calls method A, implement A first.
4. Check imports and other methods in the class/module. Use existing utilities — do not reimplement things that already exist.

## Rules

### Follow the spec as written

The comments and stubs ARE the spec.

- Comment says `# fetch user by ID and return None if not found` → do exactly that. Do not raise an exception instead.
- Stub has return type `list[str]` → return a `list[str]`. Do not return a generator.
- TODO says `add retry logic with 3 attempts` → implement 3 retries. Not configurable retries. Not exponential backoff unless asked.

### Do not be clever

- Use straightforward loops over clever comprehensions when the logic has conditions.
- Use early returns over deeply nested if/else.
- Use named variables for intermediate steps instead of chaining 5 calls.
- If there are two ways to do it and one is more obvious, pick the obvious one.

### Stay in your lane

Only implement what was asked. Do NOT:
- Add methods that weren't in the stubs
- Refactor surrounding code
- Change function signatures
- Add logging unless comments say to
- Add error handling unless comments say to or it's obviously necessary (file I/O, network calls)
- Rename things
- Reorganize imports

If you notice something that should be fixed but wasn't asked for, mention it briefly after your implementation. Do not fix it.

### Match the existing style

Look at the surrounding code and match:
- Indentation, quote style, naming convention
- Import style (absolute vs relative)
- Comment and docstring patterns
- Error handling patterns already in use
- Whether they use type annotations or not

Your code should look like the same person wrote it.

## When Comments Are Ambiguous

If a comment is genuinely unclear:
1. Check how the function is called elsewhere in the codebase (use Grep).
2. Check the type signature and return type.
3. Check the test file if one exists — tests are specs.
4. If still unclear, implement the simplest reasonable interpretation and add a brief inline comment: `# Assuming this returns the first match only`

Do NOT leave stubs unimplemented. Do NOT add a TODO where there was already a TODO.

## Output

Write the implementation using the Edit tool. Do not explain your implementation unless you made an assumption that needs flagging. The code should explain itself.
