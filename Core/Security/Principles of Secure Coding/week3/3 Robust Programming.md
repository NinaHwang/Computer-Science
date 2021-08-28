# 3. Robust Programming

Created: July 29, 2021 10:11 PM<br>
Lecture: Principles of Secure Coding<br>
Materials: https://www.coursera.org/learn/secure-coding-principles/lecture/pqPmv/module-3-introduction<br>
Type: Lecture<br>

# Robust Programming Basic Principles

## Robust Code

- A style of programming that prevents abnormal termination or unexpected actions
- handles bad input gracefully
- detects internal errors and handles them gracefully
    - On failure, provides information to aid in recovery or analysis

⇔ Fragile code

### Non-Robust Programming

Introduces security problems

- Fragile code makes assumptions about user, environment that are often wrong
- Fragile code harder to fix when a security problem is found

Introduces non-security problems

- Maintenance more complex, takes more time
- Easier for users, callers to make accidental errors in invocation

## Basic Principles

**Paranoia**: If you don't generate it, don't trust it

**Stupidity**: The user/programmer hasn't read the manuals

**Dangerous implements**: Anything expected to remain consistent across calls

**Can't happen**: Want to bet?

- Even where things seem like they can't happen, someone in the future might add code that will do what the original programmer said could never happen

## Cohesion

How well parts of a function work together

→ If one function does two completely different things, then the rate of cohesion is low

# Checklist

Check the parameter refers to a valid data structure

Always clean up deleted information → it prevents errors later on
