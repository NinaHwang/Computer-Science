# 4. Methods for Robustness

Created: August 30, 2021 5:08 PM<br>
Lecture: Principles of Secure Coding<br>
Materials: https://www.coursera.org/learn/secure-coding-principles/home/week/4<br>
Type: Lecture

# Methods Overview: Formal, Informal, and Ad Hoc Methods

## Formal Methods

Method: an organized way to do sth

Formal: a mathematically or logically verifiable method of reaching a goal

- can be proved correct
- capable of errors in assumptions axioms only

## Informal Methods

→ reaching a goal without proof

Informal: a method of reaching a goal that does not involve proof, but does allow a strong, rigorously **reasoned argument for correctness**

- no proofs of correctness
- strong argument for correctness
- capable of errors in assumptions or techniques, but the points of error can be described

## Ad Hoc Methods

- what we generally use now
- think through design, implement
- code looks right, passes our tests, so it is right

# Overview of Formal Methods

### Specification

→ what the program is to do

State goals using a precise language

- mathematical formulation
- logical language

Verify specifications are not inconsistent and meet the desired goals

- mathematical: prove theorems, consistency → state goals cleary
- logical: use verifiers, theorem provers → uncover most of the ambiguities

### Design

design it and show that your design matches/satisfies the specifications to use the correct term

### Implementation

show that your implementation satisfies the design

by transitivity, it satisfies the specifications

# Login Program Example

## Goals

- only allow authorized user onto the system
- restrict user's privileges to those allowed to that user
- log information to reconstruct any unauthorized login(break in)

## Environment and Assumptions

login program accesses correct authentication data

login program sets up correct environment

→ if not, it should not use environment, or allow any subprocess to use that environment

## Checklist

What will the users/remote servers be supplying?

- how can I check it for validity?
- what happens if it's bogus?
- what am i assuming about the environment?

What am I assuming about each library function's actions?

- this includes side effects
- what assumptions does the library function make?
- what information does it obtain from the environment and remote servers?
- does the library function do what the manual claims it does?

Have I structured my program appropriately? → HDM

- non-security relevant elements
- security-relevant elements
- modularize security-relevant elements so each module performs exactly one security-related function (one element does only one thing!)
- KISS principle

Have I checked my interfaces?

- user/programmer: no passing pointers; use some other structure(like tickets)
    - may have to for char strings, but try to avoid it
- are the call/data dependency graphs simple and easy to follow?
- do I check everything anyway?

# Incorporating Hierarchical Decomposition Methodology

## HDM(Hierarchical Decomposition Methodology)

Developed at SRI for the PSOS system

PSOS designed as a capability-based system

Design formally verified

Never implemented: implementation not funded by sponsor

## HDM Stages

Interface definition: formulate system security requirements

Hierarchical decomposition

Develop formal specs for each module: verify consistency

Refine layering: define function of each module in terms of next lower layer interfaces

Implement the system

## Example: login Program

1. Authenticate user
    - get user's authenticator(from user!)
    - get user's authentication data(from system!)
    - check for match(comparison)
2. Change UID, group info
    - get UID, primary GID, secondary GIDs
    - change to them
3. Update log files
    - for each log file, open it, write out info, close it
4. Give user appropriate command interpreter
    - obtain user's shell name
    - verify it is a valid shell
    - spawn it

## How we might instantiate this

Built on standard I/O, C libraries

- know their assumptions
    - *strcpy* assumes second buffer no longer than first
    - *strncpy* assumes same or it may omit NUL byte
    - *gets* doesn't check input length
    - and so on..

Know their outputs

- malloc(-2048) gives what?
- strcpy(a,b,-5..) does what?
