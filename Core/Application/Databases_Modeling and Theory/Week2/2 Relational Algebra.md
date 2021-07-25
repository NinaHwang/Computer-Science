# 2. Relational Algebra

Class: Databases: Modeling and Theory<br>
Created: July 25, 2021 10:19 PM<br>
Materials: https://learning.edx.org/course/course-v1:StanfordOnline+SOE.YDB-MDL_THEORY0001+2T2020/home#block-v1:StanfordOnline+SOE.YDB-MDL_THEORY0001+2T2020+type@chapter+block@159f0856e2364424927bc8f338dd9285<br>
Type: Lecture

# Select, Project, Join

Relational algebra: an algebra that forms the underpinnings of implemented languages like SQL

Query(expression) on set of relations produces relations as a result

![2%20Relational%20Algebra%2075e9dd95d4724174ac23331291c97a4b/Screen_Shot_2021-07-25_at_22.42.35.png](2%20Relational%20Algebra%2075e9dd95d4724174ac23331291c97a4b/Screen_Shot_2021-07-25_at_22.42.35.png)

## Select and Project

**Select operator**: picks certain rows

- Students with GPA>3.7 ⇒ ${\sigma}_{GPA>3.7}$Student
- Students with GPA>3.7 and HS<1000 ⇒ ${\sigma}_{GPA>3.7 \wedge HS<1000}$Student
- Applications to Stanford CS major ⇒ ${\sigma}_{CName='Stanford' \wedge major='CS'}$Apply

**Project operator**: picks certain columns

- ID and decisions. of all applications ⇒$\mathrm{\Pi}_{sID, dec}$Apply
- ID and name of students with GPA>3.7 ⇒ $\mathrm{\Pi}_{sID, sName}$(${\sigma}_{GPA>3.7}$)

## Duplicates

List of application majors and decisions

The semantics of relational algebra says that duplicates are always eliminated

⇔ SQL is based on what's known as multi-sets or bags: don't eliminate duplicates

**Cross-product**(Cartesian product): combine two relations

- Names and GPAs of students with HS>1000 who applied to CS and were rejected

    ⇒ $\mathrm{\Pi}_{sName, GPA}$(${\sigma}_{student.sID=Apply.sID \wedge HS>1000 \wedge major='CS' \wedge dec='R'}$(Student X Apply))

## Natural Join

Enforce equality on all attributes with **same name**

Eliminate one copy of duplicate attributes

- Names and GPAs of students with HS>1000 who applied to CS and were rejected

    ⇒ $\mathrm{\Pi}_{sName, GPA}$(${\sigma}_{HS>1000 \wedge major='CS' \wedge dec='R'}$)(Student ⋈ Apply)

- Names and GPAs of students with HS>1000 who applied to CS at college with enr>20,000 and were rejectedΘ

    ⇒ $\mathrm{\Pi}_{sName, GPA}$(${\sigma}_{HS>1000 \wedge major='CS' \wedge dec='R' \wedge enr>20000}$)(Student ⋈ (Apply ⋈ College))

*Natural join does not give us additional expressive power compared to cross-product, but it is very convenient notationally*

## Theta Join

Theta(Θ): condition

$Exp_{1}$, $⋈_{Θ}$ $Exp_{2}$ ≡  $σ_{Θ}$($Exp_{1}$ X $Exp_{2}$)

Basic operation implemented in DBMS

Term "join" often means theta join

# Set Operators, Renaming, Notation

## **Union operator**

- List of college and student names ⇒ $\mathrm{\Pi}_{cName}$College ∪ $\mathrm{\Pi}_{sName}$Student

## **Difference operator** → extremely useful

- IDs of students who didn't apply anywhere

    ⇒  $\mathrm{\Pi}_{sName}$(($\mathrm{\Pi}_{sID}$Student - $\mathrm{\Pi}_{sID}$Apply) ⋈ Student)

## **Intersection operator**

- Names that are both a college name and a student name

    ⇒ $\mathrm{\Pi}_{sName}$Student ∩ $\mathrm{\Pi}_{cName}$College

Intersection doesn't add expressive power

- $Exp_{1}$ ∩ $Exp_{2}$ ≡ $Exp_{1}$ - ($Exp_{1}$ - $Exp_{2}$)
- $Exp_{1}$ ∩ $Exp_{2}$ ≡ $Exp_{1}$ ⋈ $Exp_{2}$

## **Rename operator**

1. $ρ_{R(A_{1},...,A_{n})}$(E) ⭐️
2. $ρ_{R}$(E)
3. $ρ_{A_{1},...,A_{n}}$(E)

To unify schemas for set operators (syntactic necessity)

- List of college and student names ⇒ $ρ_{c(name)}$($\mathrm{\Pi}_{cName}$College) ∪ $ρ_{c(name)}$($\mathrm{\Pi}_{sName}$Student)

For disambiguation in "self-joins"

- Pairs of colleges in same state

    ⇒ $σ_{state1=state2}$($ρ_{c1(name1, state1, enr1)}$(College) X $ρ_{c2(name2, state2, enr2)}$(College))

    ⇒ $σ_{name1 < name2}$($ρ_{c1(name1, state, enr1)}$(College) ⋈ $ρ_{c2(name2, state, enr2)}$(College))
