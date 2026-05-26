# Day 6: REGEX (Regular Expressions)

## What You Learned

Regular expressions (REGEX) are powerful patterns for matching, searching, and manipulating text. REGEX enables complex string matching that would be difficult or impossible with basic string functions.

### Key REGEX Functions

1. **REGEXP()** - Tests if a string matches a pattern
   - Syntax: `string REGEXP pattern`
   - Example: `'john123' REGEXP '^[a-z]+[0-9]+$'` returns TRUE

2. **RLIKE()** - Similar to REGEXP, pattern matching
   - Syntax: `string RLIKE pattern`
   - Example: `email RLIKE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'`

3. **REGEXP_LIKE()** - Determines if string matches pattern
   - Syntax: `REGEXP_LIKE(string, pattern)`
   - Example: `REGEXP_LIKE('test@example.com', '^[a-zA-Z0-9]+@')`

4. **REGEXP_EXTRACT()** - Extracts substring matching pattern
   - Syntax: `REGEXP_EXTRACT(string, pattern)`
   - Example: `REGEXP_EXTRACT('john_doe_123', '[0-9]+')` returns `'123'`

5. **REGEXP_EXTRACT_ALL()** - Extracts all matches
   - Syntax: `REGEXP_EXTRACT_ALL(string, pattern)`
   - Example: Returns array of all matches

6. **REGEXP_REPLACE()** - Replaces substring matching pattern
   - Syntax: `REGEXP_REPLACE(string, pattern, replacement)`
   - Example: `REGEXP_REPLACE('john123mary456', '[0-9]+', 'X')` returns `'johnXmaryX'`

7. **LIKE** - Simple pattern matching with wildcards (% and _)
   - Syntax: `string LIKE pattern`
   - Example: `'john@domain.com' LIKE '%@%.com'`

### Common REGEX Patterns

- `^` - Start of string
- `$` - End of string
- `.` - Any single character
- `*` - Zero or more of previous character
- `+` - One or more of previous character
- `?` - Zero or one of previous character
- `[abc]` - Character class (a or b or c)
- `[a-z]` - Range (a through z)
- `[^abc]` - Negated class (not a, b, or c)
- `(a|b)` - Alternation (a or b)
- `\d` - Digit [0-9]
- `\D` - Non-digit
- `\w` - Word character [a-zA-Z0-9_]
- `\s` - Whitespace
- `\.` - Literal dot (escaped special character)

### Use Cases

1. **Email Validation**
   - Pattern: `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`

2. **Phone Number Validation**
   - Pattern: `^\d{3}-?\d{3}-?\d{4}$`

3. **URL Validation**
   - Pattern: `^https?://[^\s]+$`

4. **Extract Numbers from String**
   - Pattern: `\d+`

5. **Extract Domain from Email**
   - Pattern: `@(.+)$`

## Practice Areas

- Pattern matching with REGEX
- Data validation (email, phone, URL)
- Text extraction and transformation
- Complex string operations
- REGEX with aggregate functions
