# Git Commit Guide

Guidelines for Conventional Commits, commit separation, and documenting decisions.

## 1. Conventional Commits Format

```text
<type>(<optional scope>): <description>

[optional body]

[optional footer(s)]
```

### Type Reference

| Type | Purpose | Release Impact |
| :--- | :--- | :--- |
| `feat` | Adds a new feature | Minor |
| `fix` | Fixes a bug | Patch |
| `refactor` | Restructures code without changing behavior | None |
| `perf` | Improves performance | Patch / Minor |
| `test` | Adds or fixes tests | None |
| `docs` | Documentation changes only | None |
| `style` | Formatting, whitespace, missing semicolons | None |
| `chore` | Build tasks, package manager configs, maintenance | None |

## 2. Separating Refactoring from Behavioral Changes

### 2.1 Rationale
- Combining refactoring and logic changes obscures the review diff, making it difficult to verify functional correctness.
- Isolating changes allows safer rollbacks (`git revert`) without losing code improvements.

### 2.2 Workflow: Refactor First
When adding a feature or bug fix to complex legacy code:

1. **Step 1: Refactor**
   - Extract helpers, rename variables, or rearrange responsibilities.
   - Do not alter external behavior.
   - Verify existing tests pass.
   - Commit: `refactor(user): extract address validation helper`
2. **Step 2: Implement Functional Change**
   - Implement the feature or bug fix on top of the cleaned structure.
   - Add new tests.
   - Commit: `feat(user): support international postal codes`

### 2.3 Anti-patterns
- Bad: `feat: add retry logic and clean up controller` (mixed concerns in a single commit)
- Bad: Refactoring unrelated code in the middle of a bug fix commit.

## 3. Documenting Rationale in Commit Messages

Store historical context, decisions, and trade-offs in the commit message body rather than in source code comments.

### 3.1 Template

```text
<type>(<scope>): <summary line in present tense>

(Optional 1: Why)
- Problem statement or background requirement.

(Optional 2: Decision & Alternatives)
- Chosen approach and reasons for choosing it.
- Alternatives considered and reasons for rejecting them.

(Optional 3: Notes)
- Breaking changes, dependencies, or migration instructions.
```

### 3.2 Example

```text
fix(auth): handle expired refresh tokens without logging out active tabs

When multiple tabs were open, token refresh in one tab invalidated the
stored token of other tabs, causing unexpected logouts across sessions.

- Chosen: Allow a 30-second server-side grace period for refreshed tokens.
  Prevents race conditions while limiting replay attack risks.
- Rejected alternative: Syncing tokens via BroadcastChannel was rejected
  due to inconsistent behavior in private browsing modes and web workers.
- Rejected alternative: Extending token lifetime was rejected due to
  security policy constraints.

Fixes #452
```
