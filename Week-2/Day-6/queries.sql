-- day 6: regex assignment - questions and answers

-- question 1: test if 'john123' matches pattern with letters followed by numbers
-- pattern: ^[a-z]+[0-9]+$
select 'john123' rlike '^[a-z]+[0-9]+$' as is_match
-- answer: true

-- question 2: test if 'test@example.com' is a valid email format
-- pattern: ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$
select case when 'test@example.com' rlike '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' then 'valid email' else 'invalid email' end
-- answer: valid email

-- question 3: extract all numbers from 'Phone: 555-123-4567'
-- use REGEXP_EXTRACT to get first group of numbers
select regexp_extract('Phone: 555-123-4567', '[0-9]+')
-- answer: 555

-- question 4: replace all digits in 'Order12345Item67890' with 'X'
-- pattern: [0-9]
select regexp_replace('Order12345Item67890', '[0-9]', 'X')
-- answer: OrderXXXXXItemXXXXX

-- question 5: check if string contains only letters (no numbers or special chars)
-- pattern: ^[a-zA-Z]+$
select case when 'HelloWorld' rlike '^[a-zA-Z]+$' then 'letters only' else 'contains other characters' end
-- answer: letters only

-- question 6: validate phone number format (XXX-XXX-XXXX)
-- pattern: ^\d{3}-\d{3}-\d{4}$
select case when '555-123-4567' rlike '^[0-9]{3}-[0-9]{3}-[0-9]{4}$' then 'valid phone' else 'invalid phone' end
-- answer: valid phone

-- question 7: extract domain from email 'john.doe@company.com'
-- use REGEXP_EXTRACT with pattern to get text after @
select regexp_extract('john.doe@company.com', '@(.+)$')
-- answer: company.com

-- question 8: check if password meets requirements (at least 1 uppercase, 1 lowercase, 1 digit)
-- this is a complex pattern validation
select case 
  when 'Password123' rlike '[A-Z]' and 'Password123' rlike '[a-z]' and 'Password123' rlike '[0-9]' 
  then 'strong password' 
  else 'weak password' 
end
-- answer: strong password

-- question 9: extract all numbers from 'Version 2.5.3 released' using pattern \d+
select regexp_extract_all('Version 2.5.3 released', '[0-9]+')
-- answer: array('2', '5', '3')

-- question 10: replace hyphens in 'SSN: 123-45-6789' with empty string
select regexp_replace('SSN: 123-45-6789', '-', '')
-- answer: SSN: 123456789

-- question 11: check if URL starts with http or https
-- pattern: ^https?://
select case when 'https://www.example.com' rlike '^https?://' then 'valid url' else 'invalid url' end
-- answer: valid url

-- question 12: extract username from email before @ symbol
select regexp_extract('alice.smith@techcompany.org', '^([a-zA-Z.]+)@')
-- answer: alice.smith

-- question 13: validate product code format (3 letters followed by 4 numbers)
-- pattern: ^[A-Z]{3}[0-9]{4}$
select case when 'ABC1234' rlike '^[A-Z]{3}[0-9]{4}$' then 'valid code' else 'invalid code' end
-- answer: valid code

-- question 14: remove all non-alphanumeric characters from 'Hello@World#2026!'
select regexp_replace('Hello@World#2026!', '[^a-zA-Z0-9]', '')
-- answer: HelloWorld2026

-- question 15: check if string contains consecutive duplicate characters
-- pattern: (.)\1+
select case when 'Hellooo123' rlike '(.)\1+' then 'has duplicates' else 'no duplicates' end
-- answer: has duplicates

-- assignment: create a data validation query
-- validate email: must contain @ and dot, and proper format
select 
  'john@example.com' as email,
  case 
    when 'john@example.com' rlike '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' 
    then 'valid'
    else 'invalid'
  end as validation_status
-- answer: john@example.com | valid
