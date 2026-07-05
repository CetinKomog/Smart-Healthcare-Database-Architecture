# Smart Healthcare Management Database

This repository contains the design, implementation, and optimization of a relational database system built for healthcare management. The project focuses on translating conceptual data models into a normalized, high-performance physical schema.

## Technical Scope
- Database Management: SQL (MySQL/PostgreSQL compatible)
- Data Modeling: ER and EER Diagrams (Superclass/Subclass architectures)
- Normalization: 1NF, 2NF, 3NF, BCNF
- Query Optimization: B+ Tree and Hash Indexing
- Theoretical Foundations: Relational Algebra and Tuple Relational Calculus

## System Architecture
The database manages relations between Hospitals, Departments, Doctors, Patients, and Appointments. The schema enforces strict business rules, including disjoint generalizations for user roles and cascade-delete constraints for weak entities such as medical prescriptions.

![EER Diagram](Buraya-Githuba-Yukledigin-Resmin-Linkini-Yapistir)

## Implementation Details
- Schema Definition: Complete DDL script with primary keys, foreign keys, and unique constraints.
- Advanced Querying: Complex data retrieval using INNER/LEFT JOINS, GROUP BY, HAVING, and nested subqueries.
- Performance Tuning:
  - B+ Tree Indexes applied to range queries (e.g., Appointment Dates).
  - Hash Indexes implemented for exact-match lookups (e.g., Appointment Status).
  - Composite indexing utilized to prevent full-table scans during heavy multi-table joins.

## Repository Structure
## Repository Structure
* `Smart_Healthcare_Schema.sql`: The complete SQL script containing table creation, data insertion, analytical queries, and index definitions.
* `docs/Smart-Healthcare-Report.pdf`: A 17-page technical document detailing the requirements analysis, entity-relationship mapping, and mathematical proofs for normalization steps.
