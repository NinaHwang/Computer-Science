# 4. Unified Modeling Language

Created: August 19, 2021 11:39 PM
Lecture: Databases: Modeling and Theory
Materials: https://learning.edx.org/course/course-v1:StanfordOnline+SOE.YDB-MDL_THEORY0001+2T2020/block-v1:StanfordOnline+SOE.YDB-MDL_THEORY0001+2T2020+type@sequential+block@seq-vid-uml_data_modeling/block-v1:StanfordOnline+SOE.YDB-MDL_THEORY0001+2T2020+type@vertical+block@vert-vid-uml_data_modeling
Type: Lecture

# UML Data Modeling

Data Modeling: How we represent data for application

- Relational model - with design principles
- XML
- Database design model
    - Not implemented by system
    - Translated into model of DBMS

Higher-level Database Design Models

- Entity-Relationship Model(E/R)
- Unified Modeling Language(UML)
    - data modeling subset

⇒ both are graphical and can be translated to relations automatically(or semi-automatically)

## UML Data Modeling: 5 concepts

### Classes

name, attributes, methods

⇒ for data modeling: add "pk", drop methods

### Associations

Relationships between objects of two classes

**Multiplicity of Associations:** **Types of Relationships**

- one-to-one
- many-to-one
- many-to-many
- complete: every object must participate in the relationship

### Association Classes

Relationships b/w objects of two classes, *with attributes on relationships*

**Self-Associations**

Associations b/w a class and itself

### Subclasses

Hierarchy of classes

E.g. Students(Superclass) → ForeignStudents, DomesticStudents(Subclasses)

**Terminology & Properties**

- Superclass = Generalization
- Subclass = Specialization

⇒ Incomplete(partial) vs. Complete

⇒ Disjoint(Exclusive) vs. Overlapping

### Composition & Aggregation

*Nothing to do with aggregation in SQL*

Objects of one class belong to objects of another class

# UML to Relations

High-Level Database Design Model

- User-friendly(graphical) specification language
- Translated into model of DBMS

### Classes

Every class becomes a relation; pk → primary key

### Associations

Relation with key from each side

**Keys for Association Relations**

Depends on multiplicity

### Association Classes

Add attributes to relation for association

### Subclasses

- Subclass relations contain superclass key + specialized attrs.
- Subclass relations contain all attributes ⇒ when disjoint, complete
- One relation containing all superclass + subclass attrs. ⇒ when heavily overlapping

### Composition & Aggregation