# 3. Robust Programming

Created: July 29, 2021 10:11 PM
Lecture: Principles of Secure Coding
Materials: https://www.coursera.org/learn/secure-coding-principles/lecture/pqPmv/module-3-introduction
Type: Lecture

# Robust Programming Basic Principles

## Robust Code

- A style of programming that prevents abnormal termination or unexpected actions
- handles bad input gracefully
- detects internal errors and handles them gracefully
    - On failure, provides information to aid in recovery or analysis

⇔ Fragile code

## Basic Principles

**Paranoia**: If you don't generate it, don't trust it

**Stupidity**: The user/programmer hasn't read the manuals

**Dangerous implements**: Anything expected to remain consistent across calls

**Can't happen**: Want to bet?

- Even where things seem like they can't happen, someone in the future might add code that will do what the original programmer said could never happen