# 🚀 SQL Practice – Week 1 Day 3

## 📖 Overview

This practice session focuses on strengthening fundamental SQL concepts through hands-on query implementation using a relational database.

The exercises include working with:

- SQL Joins
- Aggregate Functions
- GROUP BY & HAVING Clauses
- Subqueries
- Sorting & Filtering
- NULL Handling
- Relational Database Operations

---

## 📂 Files Included

| File | Description |
|------|-------------|
| `tables.sql` | Contains table creation scripts and sample data |
| `solutionss.sql` | Contains SQL practice queries and solutions |

---

## 🗄 Database Tables Used

The practice database includes:

- `Department`
- `Staff`
- `Student`
- `Subject`
- `Mark`

These tables are connected using primary and foreign key relationships to demonstrate real-world relational database concepts.

---

## 📚 Concepts Practiced

### 🔹 SQL Joins
- INNER JOIN
- LEFT JOIN
- Multi-table Joins

### 🔹 Aggregate Functions
- `COUNT()`
- `SUM()`
- `AVG()`
- `MAX()`
- `MIN()`

### 🔹 GROUP BY & HAVING
- Department-wise calculations
- Aggregate-based filtering

### 🔹 Subqueries
- Nested queries
- Salary and marks comparison

### 🔹 Filtering & Sorting
- `WHERE`
- `ORDER BY`
- Conditional queries

### 🔹 NULL Handling
- Identifying missing records
- Managing NULL values effectively

---

## ✅ Sample Queries Implemented

- Retrieve students with department details
- Find students without marks
- Display departments without students
- Calculate average CGPA department-wise
- Find highest and lowest marks by subject
- Identify staff with above-average salary
- Display second-highest salary
- Calculate total marks for each student
- Find departments with multiple staff members

---

## 💻 Technologies Used

- Databricks
- SQL

---

## 🎯 Learning Outcomes

Through this practice, the following skills were improved:

- Writing optimized SQL queries
- Understanding relational database concepts
- Performing data analysis using SQL
- Working with joins and subqueries
- Applying aggregate functions effectively
- Managing structured database records

---

## ▶️ Execution Steps

```sql
CREATE DATABASE sql_practice;
USE sql_practice;

SOURCE tables.sql;
SOURCE solutionss.sql;
