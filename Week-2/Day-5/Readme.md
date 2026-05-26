# Day 5: Null Functions

## What You Learned

Null handling is crucial in SQL. NULL represents missing, unknown, or inapplicable data. Understanding how to work with NULL values is essential for data quality and accurate analysis.

### Key Null Functions

1. **IS NULL** - Tests if a value is NULL
   - Syntax: `column_name IS NULL`
   - Example: `WHERE email IS NULL`

2. **IS NOT NULL** - Tests if a value is NOT NULL
   - Syntax: `column_name IS NOT NULL`
   - Example: `WHERE email IS NOT NULL`

3. **COALESCE()** - Returns the first non-NULL value from a list
   - Syntax: `COALESCE(value1, value2, value3, ...)`
   - Example: `COALESCE(phone, mobile, 'No Contact')` returns first available contact

4. **IFNULL()** / **ISNULL()** - Returns a replacement value if expression is NULL
   - Syntax: `IFNULL(expression, replacement_value)`
   - Example: `IFNULL(age, 0)` returns age or 0 if NULL

5. **NULLIF()** - Returns NULL if two expressions are equal
   - Syntax: `NULLIF(expression1, expression2)`
   - Example: `NULLIF(salary, 0)` returns NULL if salary is 0

6. **NVL()** - Similar to COALESCE, returns first non-NULL value (Oracle/SQL Server)
   - Syntax: `NVL(expression1, expression2)`
   - Example: `NVL(commission, 0)`

7. **CASE...WHEN** - Conditional logic to handle NULL values
   - Syntax: `CASE WHEN condition THEN value ELSE value END`
   - Example: `CASE WHEN age IS NULL THEN 'Unknown' ELSE age END`

8. **COUNT(*)** vs **COUNT(column)** - Different NULL handling
   - `COUNT(*)` counts all rows including NULL
   - `COUNT(column)` counts only non-NULL values

9. **Comparison with NULL** - Special considerations
   - `NULL = NULL` returns NULL (not TRUE)
   - Use `IS NULL` instead of `= NULL`

## Important NULL Concepts

- NULL is not the same as zero, empty string, or FALSE
- NULL propagates in arithmetic operations (NULL + 5 = NULL)
- Comparison operators with NULL always return NULL/FALSE
- Aggregate functions (SUM, AVG, COUNT) skip NULL values
- DISTINCT counts NULL as one value

## Practice Areas

- Handling missing data
- Providing default values
- NULL filtering and checking
- Null-safe joins and comparisons
- Data quality assessment
