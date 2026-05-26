# Day 1: String Functions

## What You Learned

String functions in SQL allow you to manipulate and work with text data. These are essential for data cleaning, formatting, and transformation.

### Key String Functions

1. **UPPER()** - Converts string to uppercase
   - Syntax: `UPPER(string)`
   - Example: `UPPER('hello')` returns `'HELLO'`

2. **LOWER()** - Converts string to lowercase
   - Syntax: `LOWER(string)`
   - Example: `LOWER('HELLO')` returns `'hello'`

3. **LENGTH()** / **LEN()** - Returns the length of a string
   - Syntax: `LENGTH(string)`
   - Example: `LENGTH('hello')` returns `5`

4. **SUBSTRING()** / **SUBSTR()** - Extracts a portion of a string
   - Syntax: `SUBSTRING(string, start_position, length)`
   - Example: `SUBSTRING('hello', 1, 3)` returns `'hel'`

5. **CONCAT()** - Concatenates multiple strings
   - Syntax: `CONCAT(string1, string2, string3, ...)`
   - Example: `CONCAT('Hello', ' ', 'World')` returns `'Hello World'`

6. **TRIM()** - Removes leading and trailing spaces
   - Syntax: `TRIM(string)` or `LTRIM()`, `RTRIM()`
   - Example: `TRIM('  hello  ')` returns `'hello'`

7. **REPLACE()** - Replaces all occurrences of a substring
   - Syntax: `REPLACE(string, old_substring, new_substring)`
   - Example: `REPLACE('hello world', 'world', 'SQL')` returns `'hello SQL'`

8. **INSTR()** - Finds the position of a substring
   - Syntax: `INSTR(string, substring)`
   - Example: `INSTR('hello world', 'world')` returns `7`

9. **REVERSE()** - Reverses a string
   - Syntax: `REVERSE(string)`
   - Example: `REVERSE('hello')` returns `'olleh'`

10. **INITCAP()** - Converts first letter of each word to uppercase
    - Syntax: `INITCAP(string)`
    - Example: `INITCAP('hello world')` returns `'Hello World'`

## Practice Areas

- Text manipulation and formatting
- Data cleaning and standardization
- Pattern matching and searching
- String concatenation
