# Day 2: Date Manipulation

## What You Learned

Date manipulation functions allow you to work with dates, times, and intervals. These are crucial for time-series analysis, business logic, and data analysis.

### Key Date Functions

1. **CURRENT_DATE()** - Returns the current date
   - Syntax: `CURRENT_DATE()`
   - Example: `CURRENT_DATE()` returns `2026-05-17`

2. **CURRENT_TIMESTAMP()** - Returns the current date and time
   - Syntax: `CURRENT_TIMESTAMP()`
   - Example: `CURRENT_TIMESTAMP()` returns `2026-05-17 14:30:45.123`

3. **DATE()** - Extracts the date part from a timestamp
   - Syntax: `DATE(timestamp)`
   - Example: `DATE('2026-05-17 14:30:45')` returns `2026-05-17`

4. **YEAR()** - Extracts the year from a date
   - Syntax: `YEAR(date)`
   - Example: `YEAR('2026-05-17')` returns `2026`

5. **MONTH()** - Extracts the month from a date
   - Syntax: `MONTH(date)`
   - Example: `MONTH('2026-05-17')` returns `5`

6. **DAY()** - Extracts the day from a date
   - Syntax: `DAY(date)`
   - Example: `DAY('2026-05-17')` returns `17`

7. **DAYOFWEEK()** - Returns the day of week (1=Sunday, 7=Saturday)
   - Syntax: `DAYOFWEEK(date)`
   - Example: `DAYOFWEEK('2026-05-17')` returns `1` (for Sunday)

8. **DATE_ADD()** - Adds days to a date
   - Syntax: `DATE_ADD(date, days)`
   - Example: `DATE_ADD('2026-05-17', 5)` returns `2026-05-22`

9. **DATE_SUB()** - Subtracts days from a date
   - Syntax: `DATE_SUB(date, days)`
   - Example: `DATE_SUB('2026-05-17', 5)` returns `2026-05-12`

10. **DATEDIFF()** - Returns the difference between two dates in days
    - Syntax: `DATEDIFF(date1, date2)`
    - Example: `DATEDIFF('2026-05-20', '2026-05-17')` returns `3`

11. **DATE_FORMAT()** - Formats a date as a string
    - Syntax: `DATE_FORMAT(date, format_string)`
    - Example: `DATE_FORMAT('2026-05-17', 'yyyy-MM-dd')` returns `'2026-05-17'`

12. **FROM_UNIXTIME()** - Converts Unix timestamp to date
    - Syntax: `FROM_UNIXTIME(unix_timestamp)`
    - Example: `FROM_UNIXTIME(1684329600)` returns `2023-05-17 20:00:00`

## Practice Areas

- Date extraction and formatting
- Date arithmetic and calculations
- Time interval calculations
- Timestamp conversions
- Date comparisons and filtering
