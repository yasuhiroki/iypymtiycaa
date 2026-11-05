# Code Comments Guide

Guidelines for writing minimal, purposeful code comments.

## 1. Core Principle: Comments as Last Resort

- Comments can become outdated and misleading when code changes.
- Let code explain itself through descriptive naming, small functions, and clear flow.
- Code comments must be reserved only for critical warnings and non-obvious caveats.
- Document reasons, history, and alternative solutions in commit messages instead.

## 2. When to Write Comments

Write comments only when special attention is required when modifying or referencing the code.

### 2.1 Bug Workarounds and Platform Quirks
```typescript
// NOTE: Workaround for iOS Safari < 16.4 where IndexedDB transactions
// close unexpectedly during async operations. Trigger a dummy read synchronously first.
await idbWorkaroundPing();
```

### 2.2 Critical Ordering or Side Effects
```go
// WARNING: Do not change the close order.
// Flushes must occur before closing the underlying stream to prevent data corruption.
writer.Flush()
file.Close()
```

### 2.3 Concurrency and Deadlock Constraints
```rust
// CRITICAL: Acquire locks in order (LockA -> LockB) to prevent deadlocks with worker threads.
let _guard_a = lock_a.lock();
let _guard_b = lock_b.lock();
```

### 2.4 Legal or Regulatory Business Rules
```python
# NOTE: Pre-October 2019 orders must retain the 8% tax rate per legal requirements.
rate = order.snapshot_tax_rate
```

## 3. What to Avoid

### 3.1 Obvious Statements
```python
# Bad: repeats what code already says
# Set status to active
user.status = UserStatus.ACTIVE

# Loop over items
for item in items:
    process(item)
```

### 3.2 Decision History and Discarded Options
```typescript
// Bad: keep this context in commit messages
// Initially tried Redis Pub/Sub, but switched to SQS due to scaling concerns.
// Reduced batch size from 100 to 10 after observing timeout issues.
const BATCH_SIZE = 10;
```

### 3.3 Commented-out Code
```java
// Bad: delete dead code; rely on git history instead
// List<User> users = oldRepository.findAll();
return newRepository.findActiveUsers();
```

## 4. Refactoring Patterns to Replace Comments

### 4.1 Introduce Explanatory Variables
```typescript
// Before
if (user.role === 1 && !user.isDeleted && user.failedAttempts < MAX_ATTEMPTS) { ... }

// After: variable names explain the intent
const isEligibleAdmin = user.role === Role.ADMIN && !user.isDeleted;
const hasRemainingAttempts = user.failedAttempts < MAX_ATTEMPTS;

if (isEligibleAdmin && hasRemainingAttempts) { ... }
```

### 4.2 Extract Functions
```python
# Before
def register(user_data):
    if not user_data.email or "@" not in user_data.email:
        raise ValueError("Invalid email")
    salt = generate_salt()
    hashed = hash_password(user_data.password, salt)
    db.save(...)

# After: function names explain the steps
def register(user_data):
    validate_user_data(user_data)
    hashed_password = hash_and_salt(user_data.password)
    save_user(user_data, hashed_password)
```

### 4.3 Use Guard Clauses to Reduce Nesting
```go
// Before
func ProcessOrder(order *Order) error {
    if order != nil {
        if order.IsPaid {
            // business logic
        }
    }
    return nil
}

// After: clear preconditions at the top
func ProcessOrder(order *Order) error {
    if order == nil {
        return ErrNilOrder
    }
    if !order.IsPaid {
        return ErrOrderUnpaid
    }

    return executeShipment(order)
}
```
