# 1. Introduction and Relational Databases

Created: September 27, 2021 4:20 PM
Lecture: Databases: Relational Databases and SQL
Materials: https://learning.edx.org/course/course-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020/block-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@sequential+block@ee78af0439c642bf8a50ec250504a9c8/block-v1:StanfordOnline+SOE.YDB-SQL0001+2T2020+type@vertical+block@d6b8a5f169f34a7ea09e966b7eb16460
Type: Lecture

## Introduction

Database Management System(DBMS) provides:

efficient, reliable, convenient, and safe multi-user storage of and access to massive amounts of persistent data.

→ Database systems are extremely prevalent in the world today

### Aspects of Database

- Massive: terabytes of data
- Persistent: data in the database outlives the programs that execute on that data
- Safe:
    - database systems have a number of built in mechanisms that ensure that the data remains consistent regardless of what happens(on hardware, software, power, users etc)
- Multi-user: concurrency control
- Convenient: physical data independence / high-level query languages(declarative)
- Efficient: thousands of queries/updates per second
- Reliable

## The Relational Model

- Used by all major commercial database systems
- Very simple model
- Query with high-level languages: simple yet expressive
- Efficient implementations

Database = set of named **relations** (or **tables**)

Each relation has a set of named **attributes** (or **columns**)

Each **tuple** (or **row**) has a value for each attribute

Each attribute has a **type** (or **domain**)

### Terminologies

**Schema**: structural description of relations in database

**Instance**: actual contents at given point in time

**NULL**: special value for "unknown" or "undefined"

**Key**: attribute whose value is unique in each tuple or set of attributes whose combined values are unique

→ identify specific tuples

→ for efficiency

## Querying Relational Databases

### Steps in creating and using a (relational) database

1. Design schema; create using DDL
2. "Bulk load" initial data
3. Repeat: execute queries and modifications

### Query Languages

- Relational Algebra - formal
- SQL - actual/implemented