-- day 1: string functions practice queries

-- question 1: convert the text 'databricks' to uppercase
upper('databricks')
-- answer: DATABRICKS

-- question 2: convert 'HELLO WORLD' to lowercase
lower('HELLO WORLD')
-- answer: hello world

-- question 3: find the length of the string 'SQL Training'
length('SQL Training')
-- answer: 12

-- question 4: extract the first 5 characters from 'DataBricks'
substring('DataBricks', 1, 5)
-- answer: DataB

-- question 5: extract characters from position 6 onwards in 'DataBricks'
substring('DataBricks', 6, length('DataBricks') - 5)
-- answer: ricks

-- question 6: concatenate 'Hello', 'World', and 'SQL' with spaces in between
concat('Hello', ' ', 'World', ' ', 'SQL')
-- answer: Hello World SQL

-- question 7: remove leading and trailing spaces from '  DataBricks  '
trim('  DataBricks  ')
-- answer: DataBricks

-- question 8: replace 'old' with 'new' in 'This is old code'
replace('This is old code', 'old', 'new')
-- answer: This is new code

-- question 9: find the position of 'SQL' in 'I Love SQL'
instr('I Love SQL', 'SQL')
-- answer: 8

-- question 10: reverse the string 'databricks'
reverse('databricks')
-- answer: skcirbatad

-- question 11: combine UPPER and CONCAT to create a greeting
concat(upper('hello'), ' ', upper('databricks'))
-- answer: HELLO DATABRICKS

-- question 12: extract middle name from 'John Peter Parker' (extract 'Peter')
substring('John Peter Parker', 6, 5)
-- answer: Peter

-- question 13: count spaces in 'Hello World SQL' using LENGTH
length('Hello World SQL') - length(replace('Hello World SQL', ' ', ''))
-- answer: 2

-- question 14: create a formatted string with first name in uppercase and last name in lowercase
concat(upper('john'), ' ', lower('SMITH'))
-- answer: JOHN smith

-- question 15: find and replace 'Databricks' with 'Apache Spark' in 'Databricks is great'
replace('Databricks is great', 'Databricks', 'Apache Spark')
-- answer: Apache Spark is great
