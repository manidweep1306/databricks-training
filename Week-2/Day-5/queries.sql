-- day 5: null functions practice queries

-- question 1: check if a value is NULL
select null is null
-- answer: true

-- question 2: check if a value is NOT NULL
select 'DataBricks' is not null
-- answer: true

-- question 3: use COALESCE to return first non-NULL value
select coalesce(null, null, 'Default Value')
-- answer: Default Value

-- question 4: use COALESCE with multiple options (first non-NULL)
select coalesce(null, 'Option1', 'Option2', 'Option3')
-- answer: Option1

-- question 5: use IFNULL to provide default value
select ifnull(null, 'Default')
-- answer: Default

-- question 6: use IFNULL to replace NULL with a number
select ifnull(null, 0)
-- answer: 0

-- question 7: use NULLIF to check if values are equal
select nullif(100, 100)
-- answer: null

-- question 8: use NULLIF when values are different
select nullif(100, 50)
-- answer: 100

-- question 9: use CASE to handle NULL in conditional logic
select case when null is null then 'Value is NULL' else 'Value exists' end
-- answer: Value is NULL

-- question 10: use CASE with multiple conditions
select case 
  when null is null then 'Is NULL'
  when 'text' is null then 'Is NULL'
  else 'Not NULL'
end
-- answer: Is NULL

-- question 11: count all rows (includes NULL)
select count(*) from (select null union all select 'value1' union all select 'value2')
-- answer: 3

-- question 12: count non-NULL values in a column
select count(null), count('value1')
-- answer: 0, 1

-- question 13: handle NULL in calculations
select ifnull(null, 0) + 100
-- answer: 100

-- question 14: use COALESCE for multiple backup options
select coalesce(null, null, null, 'Final Default', 'Not Reached')
-- answer: Final Default

-- question 15: combining COALESCE with CONCAT for string handling
select concat('Name: ', coalesce(null, 'Unknown'))
-- answer: Name: Unknown

-- question 16: handle NULL in ordering
select case when null is null then 0 else 1 end as sort_order
-- answer: 0

-- question 17: create conditional column based on NULL
select coalesce(null, 'No Data Available')
-- answer: No Data Available

-- question 18: use multiple COALESCE levels
select coalesce(coalesce(null, null), 'Fallback Value')
-- answer: Fallback Value

-- question 19: NULL comparison in WHERE clause
select 'Row' where null = null
-- answer: (no rows returned)

-- question 20: proper NULL checking
select 'Row' where null is null
-- answer: Row
