# 2. Secure Programming Design Principles

Class: Principles of Secure Coding
Created: July 26, 2021 3:13 PM
Type: Lecture

# Design Principles Overview

## Principles

- Least Privilege
- Fail-Safe Defaults
- Economy of Mechanism
- Complete Mediation
- Open Design
- Separation of Privilege
- Least Common Mechanism
- Least Astonishment

## Puzzle

Most operating systems, including UNIX-like ones, have an all-powerful user(e.g. root user)

⇒ Dennis Ritchie has called the existence of such a user a theoretical flaw

⇒ It is too powerful, because it combines multiple necessary functionalities into one user

⇒ What if the user makes a mistake? What if someone breaks into the system and acquires the account?

## Underlying Goals

### Simplicity

- Less to go wrong
- Fewer possible inconsistencies
- Easy to understand

### Restriction

- Minimize access
- Inhibit communication

# Principles

## Principle of Least Privilege

A subject should be given only those privileges necessary to complete its task

⇒ you only are told what you need to know

- **Function**, not identity, controls
- Rights added as needed, discarded after use
- Minimal protection domain
- Related: Least Authority: Principle of Least Authority(POLA)

    Often considered the same as Principle of Least privilege

    - Permission: controls what subject can do to an object directly
    - Authority: controls what influence a subject has over an object

## Fail-Safe Defaults

Default action is to deny access

If action fails, system as secure as when action began

## Principle of Economy of Mechanism

Keep it as simple as possible

- KISS Principle

Simpler means less can go wrong 

⇒ Don't add complexity! Very often complexity does not add security, it simply adds confusion

- And when errors occur, they are easier to understand and fix

Interfaces and interactions

⇒ should be very easy and simple for the programmer to understand

## Principle of Completion Mediation

Check every access

Usually done once, on first action

- UNIX: access checked on open, not checked thereafter

If permissions change after, may get unauthorized access

## Separation of Privilege Principle

Requires multiple conditions to grant privilege

- Separation of duty

    e.g. requiring more than two people to do something

- Defense in depth

## Principle of Open Design

Security should not depend on secrecy of design or implementation

- Popularly misunderstood to mean that source code should be public
- "Security through obscurtiy"
- Does not apply to information such as passwords or cryptographic keys

## Principle of Least Common Mechanism

Mechanism should not be shared

- Information can flow along shared channels
- Covert channels(side-channels)

Isolation

- Virtual machines
- Sandboxes(aka "jails") ⇒ run directly on the machine that the program would run on

## Principle of Least Astonishment

Security mechanisms should be designed so users understand why the mechanism works the way it does, and using mechanism is simple

- Hide complexity introduced by security mechanisms
- Ease of installation, configuration, use
- Human factors critical here