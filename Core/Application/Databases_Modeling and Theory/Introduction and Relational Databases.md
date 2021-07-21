# Introduction and Relational Databases

Class: Databases: Modeling and Theory
Created: July 21, 2021 6:13 PM
Materials: https://learning.edx.org/course/course-v1:StanfordOnline+SOE.YDB-MDL_THEORY0001+2T2020/home
Reviewed: No
Type: Lecture

# Introduction

## What DBMS Provides

Database Management System(DBMS) provides efficient, reliable, convenient, and safe multi-user storage of and access to massive amounts of persistent data.

## Features of Database System

Database systems are popular and prevalent because they are

- massive(handles terabytes of data)
    - db systems are desinged to handle data that to residing outside of memory
- persistent
    - data in the db outlives the programs that executes the data
- safe
    - ensures that the data remains consistent
- multi-user
    - concurrency control
- convenient
    - Physical Data Independence: the operations on the data are independent from the way the data is laid out
    - High-level query languages ⇒ declarative
- efficient
    - executes complex queries over gigantic amounts of data
- reliable

## Key Concepts

- Data model: a description of how the data is structured ex) XML, graph...
- Schema versus data
    - schema: the structure of the database
    - we have a bunch of data that adheres to that schema
- Data definition language(DDL)
    - setting up schema
- Data manipulation or query language(DML)
    - querying and modifying the database

# The Relational Model

- Used by all major commercial database systems
- Very simple model
- Query with high-level languages: simple yet expressive
    - querying: asking questions of databases in the model
- Efficient implementations

## Basic Constructs

Database: set of named **relations**(or **tables**)

Each relation has a set of named **attributes**(or **columns**)

Each **tuple**(or **row**) has a value for each attribute

Each attribute has a **type**(or **domain**)

### Terms

**Schema**: structural description of relations in database

- includes: name of the relation, attributes of the relation, types of those attributes..

**Instance**: actual contents at given point in time

**NULL**: special value for "unknown" or "undefined"

**Key**: attribute whose value is unique in each tuple or set of attributes whose combined values are unique

- ex) student ID, college name + state..

## Creating Relations in SQL

Create Table Student(ID, name, GPA, photo)

Create Table College(name string, state char(2), enrollment integer)

# Querying Relational Databases

## Steps in Creating and Using a (relational) Database

1. Design schema; create using DDL
2. "Bulk load" initial data
3. Repeat: execute queries and modifications

## Ad-hoc Queries in High-level Language

Some easy to pose; some a bit harder

Some easy for DBMS to execute efficiently; some harder

"Query language(**DML**)" also used to modify data

Examples

- All students with GPA > 3.7 applying to Stanford and MIT only
- All engineering departments in CA with <500 applicants
- College with highest average accept rate over last 5 years

## Queries return relations

compositional and closed ⇒ the ability to run a query over the result of the previous query

## Query Languages

- Relational Algebra
    - formal language
    - theoretically well-grounded
    - ex) $\mathrm{\Pi}_{ID}{\sigma}_{GPA>3.7 \wedge collageName="Standford"}(Student \infty Apply)$
- SQL
    - actual / implemented language
    - ex)

        ```sql
        Select Student.ID
        From Student, Apply
        Where Student.ID=Apply.ID
        AND GPA>3.7 and collageName="Stanford"
        ```
